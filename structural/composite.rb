# composite.rb

# Compose objects into tree structures to represents part-whole hierarchies.
# Lets clients treat individual objects and compositions of objects uniformly.

# 1. basic elements

module Component
  def operation
    puts 'component operation'
  end
end

module Composite
  def initialize
    @children = []
  end

  def <<(component)
    @children << component
  end

  def >>(other)
    @children.delete(other)
  end

  def [](index)
    @children[index]
  end

  def []=(index, value)
    @children[index] = value
  end

  def operation
    puts 'composite operation'

    @children.each(&:operation)
  end

  def to_s
    "children: #{@children.join(', ')}"
  end
end


# 2. implementations

class Leaf
  include Component

  def initialize(name)
    @name = name
  end

  def to_s
    "leaf[name: #{@name}]"
  end
end

class Tree
  include Component
  include Composite

  def initialize(name)
    super()
    @name = name
  end

  def to_s
    "tree[name: #{@name}; children: #{@children.join(', ')}]"
  end
end

# 3. test

tree1 = Tree.new('t1')
tree2 = Tree.new('t2')

leaf1 = Leaf.new('l1')
leaf2 = Leaf.new('l2')
leaf3 = Leaf.new('l3')

tree1 << tree2
tree1 << leaf1
tree1 << leaf2

tree2 << leaf3

puts "Hierarchy: \n#{tree1}"
puts '-------'

puts "Second element: #{tree1[1]}"
puts '-------'

tree1[1] = Leaf.new('l4')
puts "Set second element to: #{tree1[1]}"
puts '-------'

tree1 >> leaf1

puts "Hierarchy: \n#{tree1}"
puts '-------'

puts "Operation on composite: \n"

tree1.operation
puts '-------'
