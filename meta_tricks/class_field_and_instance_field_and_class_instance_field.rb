class TestMethods
  @class_instance_field = 'value_for_class_instance_field'

  def initialize
    @@class_field = 'value_for_class_field'

    @instance_field = 'value_for_instance_field'
  end

  def self.class_field
    @@class_field
  end

  def instance_field
    @instance_field
  end

  def self.class_instance_field
    @class_instance_field
  end
end

# test

instance = TestMethods.new

puts TestMethods.class_field

puts instance.instance_field

puts TestMethods.class_instance_field
