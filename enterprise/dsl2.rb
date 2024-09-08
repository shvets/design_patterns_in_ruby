# dsl2.rb

# This implementation uses class level.

class Object
  def self.property_creator(*names)
    names.each do |name|
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}
          @#{name}
        end

        def #{name}=(val)
          @#{name} = val
        end
      CODE
    end
  end
end

class Bean
  property_creator :prop1, :prop2

  def initialize(prop1, prop2)
    @prop1 = prop1
    @prop2 = prop2
  end
end

bean = Bean.new('red', 'morning')

puts bean.prop1
puts bean.prop2
