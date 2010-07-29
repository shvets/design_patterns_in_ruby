# decorator2.rb

# Attaches additional responsibilities to an object dynamically. 
# Provides a flexible alternative to subclassing for extending functionality.

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

# 3. This solution uses 'forwardable' library

require 'forwardable'

class ForwardableDecorator
  extend Forwardable

  def_delegators :@component, :operation

  def initialize(component)
    @component = component
  end
end

# 4. test

component = ForwardableDecorator.new(ConcreteComponent.new)
component.operation
puts '-------'
