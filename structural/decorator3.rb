# decorator3.rb

# This example changes original method behavior for the instance with the help of ruby "alias".

# 1. type interface

class Component
  def operation
  end
end

# 2. type implementation

class ConcreteComponent < Component
  def operation
    puts "my component"
  end
end


# 3. test

component = ConcreteComponent.new

class << component
  alias old_operation operation

  def operation
    puts "my component pre decoration"

    old_operation

    puts "my component post decoration"
  end
end

component.operation
puts '-------'
