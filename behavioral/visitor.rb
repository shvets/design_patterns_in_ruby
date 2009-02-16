# visitor.bsh

# Represents an operation to be performed on the elements of an object structure.
# Lets you define a new operation without changing the classes of the elements on which
# it operates.

# with dynamic nature of ruby you don't really need this pattern: use
# open classes feature and use intrenals as you want

# 1. type and visitor interfaces

class Visitable
  def accept(&visitor_code)
    visitor_code.call(self)
  end
end

# we don't need visitor here: code fragment instead

#class Visitor
#  def visit(visitable)
#  end
#end


# 2. type implementation woth visitable behavior

# basic parts

class MyVisitable1 < Visitable; end

class MyVisitable2 < Visitable; end

class MyVisitable3 < Visitable; end

# compound

class MyCompoundVisitable < Visitable
  def initialize
    @visitable1 = MyVisitable1.new
    @visitable2 = MyVisitable2.new

    @visitables3 = [
      MyVisitable3.new, MyVisitable3.new, MyVisitable3.new
    ]
  end;

  def accept(&visitor_code)
    visitor_code.call(self)
    #visitor.visit(self)

    # takes care of components
    @visitable1.accept(&visitor_code)
    @visitable2.accept(&visitor_code)

    @visitables3.each { |visitable| visitable.accept(&visitor_code) }
  end     
end

# 3. visitor implementations

# 4. test

visitable = MyCompoundVisitable.new

# creating visitors dynamically

visitable.accept do |visitable|
  if(visitable.kind_of? MyVisitable1)
    puts "visitor1: visiting my visitable 1"
  elsif(visitable.kind_of? MyVisitable2)
    puts "visitor1: visiting my visible 2"
  elsif(visitable.kind_of? MyVisitable3)
    puts "visitor1: visiting my visitable 3"
  elsif(visitable.kind_of? MyCompoundVisitable)
    puts "visitor1: visiting my compound visitable"
  end
end

visitable.accept do |visitable|
  if(visitable.kind_of? MyVisitable1)
    puts "visitor2: visiting my visitable 1"
  elsif(visitable.kind_of? MyVisitable2)
    puts "visitor2: visiting my visible 2"
  elsif(visitable.kind_of? MyVisitable3)
    puts "visitor2: visiting my visitable 3"
  elsif(visitable.kind_of? MyCompoundVisitable)
    puts "visitor2: visiting my compound visitable"
  end
end

