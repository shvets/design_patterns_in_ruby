# visitor2.rb

# Instead of using separate visitor class this example uses blocks of code.

# 1. type interface

module Visitable
  def accept(&visitor_code)
    visitor_code.call(self)
  end
end

# we don't need visitor here: use code fragment instead

#class Visitor
#  def visit(visitable)
#  end
#end


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

# creating visitor dynamically

visitor_code = Proc.new do |visitable|
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

visitable.accept &visitor_code
