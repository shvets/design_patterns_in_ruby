# strategy2.rb

# Defines strategy on the fly with the help of ruby blocks.

# 1. strategy context

class StrategyContext
  def execute &strategy
    strategy.call(self)
  end
end

# 2. test

context = StrategyContext.new

context.execute do |context|
  # strategy 1 implementation
  puts "operation1 from #{context}"
end

context.execute do |context|
  # strategy 2 implementation
  puts "operation2 from #{context}"
end
