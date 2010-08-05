# dsl3.rb

# This is another implementation of DSL with the help of DSL build.
 
module Kernel
  def singleton_class
    class << self; self; end
  end
  
  def define_attribute(name, value=nil)
    singleton_class.send :attr_accessor, name
    
    send "#{name}=".to_sym, value unless value.nil?
  end
  
end
  
# 1. Defines DSL elements: tree, trunk, branch, root, leaf. No need to specify 
#    reltionship between them - we'll do it later with DSL builder.

module HasName
  attr_reader :name
 
  def initialize(name = '')
    @name = name
  end
  
  def to_s
    "[name: #{name}]"
  end  
end

class Leaf
  include HasName
  
  def to_s
    "Leaf[name: #{name}]"
  end  
end

class Branch
  include HasName
  
  # def to_s
  #   "Branch[name: #{name}; leaves: #{leaves.join(', ')}]"
  # end  

  def to_s
    "Branch[name: #{name}]"
  end
end

class Root
  include HasName
    
  def to_s
    "Root[name: #{name}]"
  end    
end

class Trunk
  include HasName

  # 
  # def to_s
  #   "  Trunk[\n" +
  #   "    branches: #{branches.join(', ')};\n" +
  #   "    roots: #{roots.join(', ')};\n" +
  #   "  ]"
  # end

  def to_s
    "Trunk[name: #{name}]"
  end
end

class Tree
  include HasName

  def type(type)
   @type = type
  end

  # def to_s
  #   "Tree [\n  name: #{name};\n  type: #{@type};\n  trunk: #{@trunk}\n]"
  # end
  
  def to_s
    "Tree[name: #{name}]"
  end  
end

# 2. DSL Builder

class DSLBuilder
 
  def initialize &block
    self.instance_eval(&block)
  end
  
  def root root_name
    @root = root_name
    
    root_class = Object::const_get("#{root_name.to_s.capitalize}")

    root_class.instance_eval do
      define_method root_name do |name, &block|
        p "in #{root_name}"
        root_instance = root_class.new(name)
      
        root_instance.instance_eval(&block)  
      end
    end    
  end
    
  def one_to_one parent_name, child_name
    parent_class = Object::const_get("#{parent_name.to_s.capitalize}")
    child_class = Object::const_get("#{child_name.to_s.capitalize}")

    parent_class.instance_eval do
      define_method child_name do |&block|
                p "in #{child_name}"
        instance = child_class.new       
        
        define_attribute(child_name, instance)
      
        instance.instance_eval(&block)   
      end
    end
  end
  
  def one_to_many parent_name, child_name, suffix
    parent_class = Object::const_get("#{parent_name.to_s.capitalize}")
    child_class = Object::const_get("#{child_name.to_s.capitalize}")

    parent_class.instance_eval do
      define_method child_name do |name, &block|
                p "in #{child_name}"
        children = define_attribute("#{child_name}#{suffix}".to_sym)       
        children = [] if children.nil?
      
        instance = child_class.new(name)      
        instance.instance_eval(&block) unless block.nil?
        
        children << instance 
        
        instance
      end
    end
  end
 
  def build name
    language_class = Class.new   
    language = language_class.new
    language.define_attribute(:root, @root)
    
    def language.program(name, &block)
      root_class = Object::const_get("#{root.to_s.capitalize}")
      
      instance = root_class.new(name)

      instance.instance_eval(&block)  
    end
    
    language
  end
  
end

# 3. Creates new 'tree' language with the help of DSL builder.

dsl_builder = DSLBuilder.new do
  root :tree
  one_to_one :tree, :trunk
  one_to_many :trunk, :branch, :es
  one_to_many :trunk, :root, :s
  one_to_many :branch, :leaf, :s  
end

tree_language = dsl_builder.build :tree

# 4. Creates new tree description in 'tree' language.

tree_language.program :my_favorite_tree do
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
  
  puts self # prints the tree
end
