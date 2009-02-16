# template_method.rb

# Defines the skeleton of an algorithm in an operation, deferring some steps
# to subclases. Let subclasses redefine certain steps of an algorithm without 
# changing the algorithm's structure.

# 1. template

# ruby language extension
class Module

  # Invoked during class definitions
  def abstract_methods(*names)
    names.each do | name |
      define_method "#{name}" do
        raise 'Called abstract method: ' + name.to_s
      end
    end
  end

end

module AlgorithmTemplate   
  # These methods are "primitive operations" and must be overridden in the concrete templates
  abstract_methods :step1, :step2, :step3
 
  # The "template method" - calls the concrete class methods, is not overridden
  def some_template_method
    step1
    step2
    step3
  end  
end

# 2. adding template behavior

class MyAlgorithmTemplate1
  include AlgorithmTemplate

  protected 

  def step1
    puts "algorithm1: step1"
  end

  def step2
    puts "algorithm1: step2"
  end

  def step3
    puts "algorithm1: step3"
  end
end

class MyAlgorithmTemplate2
  include AlgorithmTemplate

  protected 

  def step1
    puts "algorithm2: step1"
  end

  def step2
    puts "algorithm2: step2"
  end

  def step3
    puts "algorithm2: step3"
  end
end

# test

#AlgorithmTemplate.new.some_template_method

template1 = MyAlgorithmTemplate1.new
template2 = MyAlgorithmTemplate2.new

template1.some_template_method
template2.some_template_method
