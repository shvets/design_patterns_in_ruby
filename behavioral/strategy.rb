# strategy.rb

# Defines a family of algorithms, encapsulate each one, and
# make them interchangeable. Let the algorithm vart independently from
# clients that use it.

# 1. strategy implementations

class MyStrategy1
  def operation
    puts "operation1"
  end
end

class MyStrategy2
  def operation
     puts "operation2"
  end
end

# 2. context

class StrategyContext 
  attr_writer :strategy

  def execute
    @strategy.operation
  end
end

# 3. test

context = StrategyContext.new

strategy1 = MyStrategy1.new
strategy2 = MyStrategy2.new

context.strategy = strategy1
context.execute

context.strategy = strategy2
context.execute
