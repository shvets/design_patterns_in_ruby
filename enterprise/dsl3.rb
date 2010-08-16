# dsl3.rb

# This is another implementation of DSL with the help of DSL build.

module Kernel
  def singleton_class
    class << self; self; end
  end

  def define_attribute(name, value=nil)
    unless instance_variable_defined?("@#{name}".to_sym)
      singleton_class.send :attr_accessor, name

      send "#{name}=".to_sym, value unless value.nil?
    end

    instance_variable_get "@#{name}".to_sym
  end

  def constantize name
    Kernel.const_get(name.to_s.capitalize)
  end
end


module Visitable
  def accept(level=1, &visitor_code)
    visitor_code.call(level, self)
  end
end

module HasName
  attr_accessor :name
end

# 1. Defines DSL elements: tree, trunk, branch, root, leaf. No need to specify 
#    reltionship between them - we'll do it later with DSL builder.

class TreeElement
  include HasName
end

class Leaf < TreeElement
end

class Branch < TreeElement
end

class Root < TreeElement
end

class Trunk < TreeElement
end

class Tree < TreeElement
  attr_accessor :type

  def type(type)
    @type = type
  end
end


# 2. DSL Builder

class DSLBuilder
  def initialize &block
    @records = []
    instance_eval(&block)
  end

  def parent
    @parent
  end

  def parent parent
    @parent = parent
    @records << { :root => parent }

    parent_class = constantize(parent)

    parent_class.instance_eval do
      define_method parent do |name, &block|
        instance = parent_class.new(name)

        instance.instance_eval(&block)
      end
    end
  end

  def child parent, child
    @records << { :parent => parent, :child => child }
    
    parent_class = constantize(parent)
    child_class = constantize(child)
    
    parent_class.instance_eval do
      define_method child do |&block|
        child = define_attribute(child, child_class.new)

        child.instance_eval(&block) unless block.nil?
      end
    end
  end

  def children parent, child
    @records << { :parent => parent, :children => child }    
    
    parent_class = constantize(parent)
    child_class = constantize(child)

    parent_class.instance_eval do
      define_method child do |name, &block|
        instance = child_class.new
        instance.name = name

        children = define_attribute("#{child}_list".to_sym, [])

        children << instance

        instance.instance_eval(&block) unless block.nil?
      end
    end
  end

  def build name
    language_class = Class.new
    language = language_class.new
    language.define_attribute(:parent, @parent)
    language.define_attribute(:name, name)

    def language.program(name, &block)
      instance = constantize(@parent).new
      instance.name = name

      instance.instance_eval(&block)

      instance
    end

    assign_visitors(language)
    
    language
  end

  private


  def assign_visitor_to element
    element_class = constantize(element)
    element_class.send :include, Visitable unless element_class.include? Visitable     
  end
  
  def assign_visitors language
    p @records
    @records.each do |record|
      record.each do |key, value|
        if key == :root
          assign_visitor_to(value) 
        elsif key == :child
          assign_visitor_to(value)
    
          parent_class = constantize(record[:parent])
 
          parent_class.class_eval do
            alias original_accept accept
          
            def accept(level=1, &visitor_code)
              original_accept &visitor_code

              # takes care of components
              instance_variable_get("@trunk".to_sym).accept(level+1, &visitor_code)
            
            end
          end         
        elsif key == :children
          assign_visitor_to(value) 
        end    
      end
    end
    
    
   Branch.class_eval do
     alias original_accept accept
   
     def accept(level=1, &visitor_code)
       original_accept level, &visitor_code
   
       # takes care of components
       @leaf_list.each do |visitable|
         visitable.accept(level+1, &visitor_code)
       end
     end
   end
   
    Trunk.class_eval do
      alias original_accept accept
   
      def accept(level=1, &visitor_code)
        original_accept level, &visitor_code
   
        # takes care of components
        @branch_list.each do |visitable|
          visitable.accept(level+1, &visitor_code)
        end
   
        @root_list.each do |visitable|
          visitable.accept(level+1, &visitor_code) 
        end
      end
    end

    # Tree.class_eval do
    #   alias original_accept accept
    # 
    #   def accept(level=1, &visitor_code)
    #     original_accept &visitor_code
    # 
    #     # takes care of components
    #     @trunk.accept(level+1, &visitor_code)
    #   end
    # end
    
    
  end
end

# def assign_visitor_to object   
#   object.extend Visitable unless object.class.include? Visitable
# end
#  
# def create_visitables object
#   assign_visitor_to(object)
#   
#   def object.accept(&visitor_code)
#     visitor_code.call(self)
# 
#     # takes care of components
#     @trunk.accept(&visitor_code)
#   end
# 
#   trunk = object.instance_variable_get("@trunk".to_sym)
# 
#   def trunk.accept(&visitor_code)
#     visitor_code.call(self)
# 
#     # takes care of components
#     @branch_list.each do |visitable|
#       visitable.accept(&visitor_code)
#     end
# 
#     @root_list.each do |visitable| 
#        visitable.accept(&visitor_code)
#     end
#   end
# 
#   branch_list = trunk.instance_variable_get("@branch_list".to_sym)
# 
#   branch_list.each do |branch|
#     def branch.accept(&visitor_code)
#       visitor_code.call(self)
# 
#       # takes care of components
#       @leaf_list.each do |visitable|
#         assign_visitor_to(visitable)
# 
#         visitable.accept(&visitor_code)
#       end
#     end
#   end
# 
#   root_list = trunk.instance_variable_get("@root_list".to_sym)
# 
#   root_list.each do |root|
#     def root.accept(&visitor_code)
#       visitor_code.call(self)
#     end
#   end
# end

# 3. Creates new 'tree' language with the help of DSL builder.

dsl_builder = DSLBuilder.new do
  parent :tree

  child :tree, :trunk
  children :trunk, :branch
  children :trunk, :root
  children :branch, :leaf
end

tree_language = dsl_builder.build :tree

puts "language: #{tree_language.name}"

# 4. Creates new tree description in 'tree' language.

tree_program = tree_language.program :my_favorite_tree do
  type :oak

  trunk do
    branch :b1 do
      leaf :l1
      leaf :l2
    end

    branch :b2 do
      leaf :l3
    end

    root :r1
    root :r2
  end
end

# printing the program

puts "program: #{tree_program.name}"
puts "program body:"

# visiting all program's elements

# create_visitables(tree_program)

tree_program.accept do |level, visitable|
  spaces = " " * ((level-1)*2)
  
  if(visitable.kind_of? Tree)
    puts "#{spaces}Tree[name: #{visitable.name}; type: ]"
  elsif(visitable.kind_of? Trunk)
    puts "#{spaces}Trunk"
  elsif(visitable.kind_of? Branch)
    puts "#{spaces}Branch[name: #{visitable.name}]"
  elsif(visitable.kind_of? Root)
    puts "#{spaces}Root[name: #{visitable.name}]"
  elsif(visitable.kind_of? Leaf)
    puts "#{spaces}Leaf[name: #{visitable.name}]"
  else
    puts "oops: #{visitable.class.name}"
  end
end
