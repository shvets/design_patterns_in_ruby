# visitor1.rb

# Represents an operation to be performed on the elements of an object structure.
# Lets you define a new operation without changing the classes of the elements
# on which it operates.

# 1. visitable and visitor interfaces


def underscore(camel_cased_word)
  camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr("-", "_").
      downcase
end

module Visitable
  def accept(visitor)
    visitor.visit(self)
  end
end

module Visitor
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

  alias original_accept accept

  def accept(visitor)
    original_accept visitor

    # takes care of components
    @visitable1.accept(visitor)
    @visitable2.accept(visitor)

    @visitables3.each { |visitable| visitable.accept(visitor) }
  end     
end

# 3. visitor implementations

class MyCompoundVisitor1
  include Visitor

  def visit(visitable)
    method_name = "visit_#{underscore(visitable.class.name)}"

    send method_name.to_sym, visitable
  end

  def visit_my_visitable1 visitable
    puts "visitor: visiting my visitable 11"
  end

  def visit_my_visitable2 visitable
    puts "visitor: visiting my visible 12"
  end

  def visit_my_visitable3 visitable
    puts "visitor: visiting my visitable 13"
  end

  def visit_my_compound_visitable visitable
    puts "visitor: visiting my compound visitable 1"
  end
end

# 4. test

# creating complex visitable

visitable = MyCompoundVisitable.new

visitor1 = MyCompoundVisitor1.new
  
visitable.accept(visitor1)

# creating visitor dynamically

class MyCompoundVisitor2
  include Visitor
  def visit visitable
    if(visitable.kind_of? MyVisitable1)
      puts "visitor: visiting my visitable 21"
    elsif(visitable.kind_of? MyVisitable2)
      puts "visitor: visiting my visible 22"
    elsif(visitable.kind_of? MyVisitable3)
      puts "visitor: visiting my visitable 23"
    elsif(visitable.kind_of? MyCompoundVisitable)
      puts "visitor: visiting my compound visitable 2"
    end
  end
end

visitor2 = MyCompoundVisitor2.new

visitable.accept(visitor2)

