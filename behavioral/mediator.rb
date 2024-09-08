# mediator.bsh

# Define an object that encapsulates how a set of objects interact.
# Promotes loose coupling by keeping objects from referring to each other 
# explicitly and it lets you vary their interactions independently.

# 1. mediator interface

class Mediator
  def operation1
  end

  def operation2
  end
end

# 2. Mediator implementation

class MyMediator < Mediator
  def operation1
    puts 'mediator: operation 1'
  end

  def operation2
    puts 'mediator: operation 2'
  end
end

# 3. Concrete classes that are aware of mediator

class Product1
  def initialize(mediator)
    @mediator = mediator
  end

  def perform
    @mediator.operation1
  end
end

class Product2
  def initialize(mediator)
    @mediator = mediator
  end

  def perform
    @mediator.operation1
  end
end

class Product3
  def initialize(mediator)
    @mediator = mediator
  end

  def perform
    @mediator.operation2
  end
end

# 4. test

mediator = MyMediator.new

product11 = Product1.new(mediator)
product12 = Product1.new(mediator)

product21 = Product2.new(mediator)
product22 = Product2.new(mediator)

product31 = Product3.new(mediator)
product32 = Product3.new(mediator)

product11.perform
product12.perform

product21.perform
product21.perform

product31.perform
product31.perform

