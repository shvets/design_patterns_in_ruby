# 1. This class has methods that can add aspect to class and instance methods

class AspectWrapper
  def wrap_class_with_aspect clazz, methods_to_wrap, &aspect

    handler_class = Class.new {
      @clazz = clazz
      @methods_to_wrap = methods_to_wrap
    }

    handler_class.instance_eval do
      methods_to_wrap.each do |method|
        self.define_singleton_method method do |*params|
          aspect.call @clazz, method, *params
        end
      end
    end

    handler_class
  end

  def wrap_instance_with_aspect instance, methods_to_wrap, &aspect
    new_module = to_module instance, methods_to_wrap, &aspect

    instance.extend new_module
  end

  def to_module instance, methods_to_wrap, &aspect
    cloned_instance = instance.clone

    Module.new do
      methods_to_wrap.each do |method|
        define_method method do |*params|
          aspect.call cloned_instance, method, *params
        end
      end
    end
  end
end

# 2. Create aspect: block of code that has caller, method_name and method parameters

my_aspect = lambda do |caller, method_name, *params|
  puts "Before original call"

  caller.send method_name, *params

  puts "After original call"
end

# 3. Create new class

class MyClass
  def self.class_method
    puts "Original class method call..."
  end

  def instance_method
    puts "Original instance method call..."
  end
end

# Test it

puts "Calling class method before applying aspect:"

MyClass.class_method
puts "---"

weaved_class = AspectWrapper.new.wrap_class_with_aspect(MyClass, [:class_method], &my_aspect)

puts "Calling class method after applying aspect:"

weaved_class.class_method
puts "---"

instance = MyClass.new

puts "Calling instance method before applying aspect:"
instance.instance_method
puts "---"

AspectWrapper.new.wrap_instance_with_aspect(instance, [:instance_method], &my_aspect)

puts "Calling instance method after applying aspect:"
instance.instance_method
puts "---"