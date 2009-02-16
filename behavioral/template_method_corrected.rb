# template-method-corrected.bsh

# Use Strategy pattern instead.

# Prefer composition to inheritance
# - Allows greater reuse
# - Communicates intent better
# - Easier to understand
# - Easier to maintain
# - More robust as it evolves
# Inheritance is a very strong form of coupling
# - Especially in a single-inheritance language

# 1. Strategy 

class StrategyAsCodeBlock
  def initialize &code
    @code = code
  end

  def operation
    @code.call
  end
end

# 2. template algorithm; also acts as strategy context

module AlgorithmTemplate  
  def initialize
    @steps = [] # strategies
  end

  # The "template method"
  def some_template_method 
    @steps.each { | step | step.operation }
  end  
end

class MyAlgorithmTemplate1
  include AlgorithmTemplate

  def initialize
    super

    @steps << StrategyAsCodeBlock.new { puts "stategy1: step1" }
    @steps << StrategyAsCodeBlock.new { puts "stategy1: step2" }
    @steps << StrategyAsCodeBlock.new { puts "stategy1: step3" } 
  end
end

class MyAlgorithmTemplate2
  include AlgorithmTemplate

  def initialize
    super

    @steps << StrategyAsCodeBlock.new { puts "stategy2: step1" }
    @steps << StrategyAsCodeBlock.new { puts "stategy2: step2" }
    @steps << StrategyAsCodeBlock.new { puts "stategy2: step3" } 
  end
end


# test

template1 = MyAlgorithmTemplate1.new
template2 = MyAlgorithmTemplate2.new

template1.some_template_method
template2.some_template_method

