# 1. This module has method that creates class and instance methods for block of code

module UseCommonCode
  def use_common_code method_name,  &common_code_block
    # define method for the class

    self.define_singleton_method method_name do
      puts "Inside class method:"
      common_code_block.call
    end

    # define method for the instance

    self.send :define_method, method_name do
      puts "Inside instance method:"
      common_code_block.call
    end
  end
end

# 2. New class

class MyClass
  # 2.1 Include module
  extend UseCommonCode

  # 2.2. Define common block of code

  common_code_block = lambda do
    "I'm common!"
  end

  # 2.3. register block as common
  use_common_code :my_method, &common_code_block
end

# Test it

puts MyClass.my_method # class method

my_instance = MyClass.new

puts my_instance.my_method # instance method

