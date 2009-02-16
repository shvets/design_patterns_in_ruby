# decorator.rb

# Attaches additional responsibilities to an object dynamically. Provides
# a flexible alternative to subclassing for extending functionality.

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

# 3. traditional solution based on inheritance

class TraditionalComponent < ConcreteComponent
  def pre_decoration
    puts "my component pre decoration"
  end

  def post_decoration
    puts "my component post decoration"
  end

  def operation
    pre_decoration

    super

    post_decoration
  end
end

# 4. solution based on decorator

class Decorator < Component
  def initialize(component)
    @component = component
  end

  def pre_decoration
    puts "my component pre decoration"
  end

  def post_decoration
    puts "my component post decoration"
  end

  def operation
    pre_decoration

    @component.operation

    post_decoration
  end
end

# 5.

require 'forwardable'

class ForwardableDecorator
  extend Forwardable

  def_delegators :@component, :operation

  def initialize(component)
    @component = component
  end
end

# 6. test

component1 = TraditionalComponent.new
component1.operation
puts '-------'

component2 = Decorator.new(ConcreteComponent.new)
component2.operation
puts '-------'

component3 = ForwardableDecorator.new(ConcreteComponent.new)
component3.operation
puts '-------'

component4 = ConcreteComponent.new

class << component4
  alias old_operation operation

  def operation
    puts "my component pre decoration"

    old_operation

    puts "my component post decoration"
  end
end

component4.operation
puts '-------'
