# facade.rb

# Provides an unified interface to a set of interfaces in a subsystem.
# Defines a high-level interface that makes the subsystem easier to use.

# 1. different parts of the system

class Component1
  def operation1
    puts 'operation1'
  end
end

class Component2
  def operation2
    puts 'operation2'
  end
end

class Component3
  def operation3
    puts 'operation3'
  end
end

# 2. facade to different parts; end user will communicate with them through the facade only.

class MyFacade
  def do_something
    component1 = Component1.new
    component2 = Component2.new
    component3 = Component3.new

    component1.operation1
    component3.operation3
    component2.operation2
  end
end

# 3. test

facade = MyFacade.new

facade.do_something
