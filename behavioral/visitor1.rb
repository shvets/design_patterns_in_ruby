# visitor1.rb

# Represents an operation to be performed on the elements of an object structure.
# Lets you define a new operation without changing the classes of the elements
# on which it operates.

# 1. visitable and visitor interfaces

module Visitable
  def accept(visitor)
    visitor.visit(self)
  end
end

class Visitor
 def visit(visitable)
 end
end


# 2. type implementation with visitable behavior

# basic parts

class MyVisitable1 
  include Visitable
end

class MyVisitable2
  include Visitable
end
    
class MyVisitable3
  include Visitable
end


# compound

class MyCompoundVisitable
  include Visitable
    
  def initialize
    @visitable1 = MyVisitable1.new
    @visitable2 = MyVisitable2.new

    @visitables3 = [
      MyVisitable3.new, MyVisitable3.new, MyVisitable3.new
    ]
  end

  def accept(visitor)
    visitor.visit(self)

    # takes care of components
    @visitable1.accept(visitor)
    @visitable2.accept(visitor)

    @visitables3.each { |visitable| visitable.accept(visitor) }
  end     
end

# 3. visitor implementations

# 4. test

# creating complex visitable

visitable = MyCompoundVisitable.new

# creating visitor dynamically

class MyVisitor < Visitor
  def visit visitable
    if(visitable.kind_of? MyVisitable1)
      puts "visitor: visiting my visitable 1"
    elsif(visitable.kind_of? MyVisitable2)
      puts "visitor: visiting my visible 2"
    elsif(visitable.kind_of? MyVisitable3)
      puts "visitor: visiting my visitable 3"
    elsif(visitable.kind_of? MyCompoundVisitable)
      puts "visitor: visiting my compound visitable"
    end
  end
end

visitor = MyVisitor.new
  
visitable.accept(visitor)


