# composite.bsh

# Compose objects into tree structures to represents part-whole hierarchies.
# Let's clientstreat individual objects and compositions of objects uniformly.

# 1. basic behavior in form of trait-module

module Component
  def operation
  end
end

module Composite
  def initialize
    @children = []
  end

  def <<(component)
    @children << component
  end

  def >>(component)
    @children.delete(component)
  end

  def [](index)
    @children[index]
  end

  def []=(index, value)
    @children[index] = value
  end

  def operation
    puts "composite operation"

    @children.each {|child| child.operation}
  end

  def to_s
    "children: " + @children.join(', ')
  end                    
end


# 2. implementations 

class Leaf
  include Component

  def initialize(name)
    @name = name
  end

  def operation
    puts "leaf operation"
  end

  def to_s
    @name
  end                    
end

class Container
  include Component
  include Composite

  def initialize(name)
    super()
    @name = name
  end

  def to_s
    "[ name: " + @name + "; children: " + @children.join(', ') + "]"
  end                    
end

# 3. test

container1 = Container.new("c1")
container2 = Container.new("c2")

leaf1 = Leaf.new("l1")
leaf2 = Leaf.new("l2")
leaf3 = Leaf.new("l3")

container1 << container2
container1 << leaf1
container1 << leaf2

container2 << leaf3

puts "Hierarchy: \n" + container1.to_s
puts "-------"

puts "Second element: " + container1[1].to_s
puts "-------"

container1[1] = Leaf.new("l4")
puts "Set second element to: " + container1[1].to_s
puts "-------"

container1 >> leaf1

puts "Hierarchy: \n" + container1.to_s
puts "-------"

puts "Operation on composite: \n"

container1.operation
puts "-------"
