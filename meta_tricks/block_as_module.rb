# How to call method defined in block

# 1. Have a block with new method

code_block = lambda do
  public

  def my_method
    "my_method: #{my_field}" # Note: access variable from outer class
  end
end

# 2. Have a class that needs to be extended with new method from block

class MyClass
  attr_reader :my_field

  def initialize &code_block
    @my_field = "Hello, World!"

    # 3. This method "inserts" block's method into current class

    inline_block self.class, code_block
  end

  def inline_block clazz, code_block
    clazz.define_singleton_method(:include_new_context, &code_block) # define singleton method associated with block

    clazz.include_new_context # by executing new method we "extending" class body with block body
  end
end

# 4. Test it

my_instance = MyClass.new &code_block

puts my_instance.my_method # block's method uses variable defined inside this class