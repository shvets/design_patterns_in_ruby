# template-method3.bsh

# This example uses Strategy Pattern for storing steps of template method algorithm.

# 1. Strategy 

class TemplateMethodStep
  def initialize &code
    @code = code
  end

  def operation
    @code.call
  end
end

# 2. template method algorithm; also acts as strategy context

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

    @steps << TemplateMethodStep.new { puts "stategy1: step1" }
    @steps << TemplateMethodStep.new { puts "stategy1: step2" }
    @steps << TemplateMethodStep.new { puts "stategy1: step3" } 
  end
end

class MyAlgorithmTemplate2
  include AlgorithmTemplate

  def initialize
    super

    @steps << TemplateMethodStep.new { puts "stategy2: step1" }
    @steps << TemplateMethodStep.new { puts "stategy2: step2" }
    @steps << TemplateMethodStep.new { puts "stategy2: step3" } 
  end
end


# test

template1 = MyAlgorithmTemplate1.new
template2 = MyAlgorithmTemplate2.new

template1.some_template_method
template2.some_template_method

