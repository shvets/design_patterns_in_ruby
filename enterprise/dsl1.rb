# dsl1.rb

# Domain Specific Languange (DSL) is simple set of commands for serving a specific domain. 
# It could be implemented on object or class level. With object level we've got DSL scripts, with
# the class level - metaprogramming statements

# This implementation uses object level.
  
# 1. Defines DSL elements: tree, trunk, branch, root, leaf.
#    If one element appears inside another, use collection and don't forget to eval 
#    incoming block for the parent.

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
    
  attr_reader :leaves
  
  def initialize name
    super
    
    @leaves = [] 
  end

  def leaf(name, &block)
    leaf = Leaf.new(name)    
    leaf.instance_eval(&block) if block_given?

    @leaves << leaf
    
    leaf  
  end
  
  def to_s
    "Branch[name: #{name}; leaves: #{leaves.join(', ')}]"
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
    
  attr_reader :branches, :roots

  def initialize
    super
   
    @branches = [] 
    @roots = []   
  end

  def branch(name, &block)
    branch = Branch.new(name)    
    branch.instance_eval(&block) if block_given?
  
    @branches << branch
    
    branch
  end
  
  def root(name, &block)
    root = Root.new(name)    
    root.instance_eval(&block) if block_given?
  
    @roots << root
    
    root
  end

  def to_s
    "  Trunk[\n" +
    "    branches: #{branches.join(', ')};\n" +
    "    roots: #{roots.join(', ')};\n" +
    "  ]"
  end
end

class Tree
  include HasName

  def initialize name
    super  
    @trunk = Trunk.new
  end

  def type(type)
   @type = type
  end

  def trunk(&block)
    @trunk.instance_eval(&block)
  end

  def to_s
    "Tree [\n  name: #{name};\n  type: #{@type};\n  trunk: #{@trunk}\n]"
  end
end

# 2. Defines DSL for describing the tree. It acts as the tree builder.

module Tree::DSL
  def tree(name, &block)
    tree = Tree.new(name)
    tree.instance_eval(&block)
    
    return tree
  end
end

# 3. test

include Tree::DSL

# tree description

tree :my_favorite_tree do
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

