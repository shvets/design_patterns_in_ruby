module UtilityModule1
  extend self

  def some_method
    "some_method1"
  end
end

module UtilityModule2
  module_function # this is preferable over extend self

  def some_method
    "some_method2"
  end
end

module UtilityModule3
  class << self
    def some_method
      "some_method3"
    end
  end
end

require 'singleton'

class UtilityModule4
  include Singleton

  def some_method
    "some_method4"
  end
end

# test

puts UtilityModule1.some_method
puts UtilityModule2.some_method
puts UtilityModule3.some_method
puts UtilityModule4.instance.some_method
