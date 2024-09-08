# prototype.rb

# Specify the kind of objects to create using prototypical instance,
# and create new objects by copying this prototype.

class Prototype
  def make_prototype
  end
end

class Product < Prototype
  attr_accessor :name

  def initialize
    @name = 'name'
  end

  def make_prototype
    cloned_product = Product.new

    cloned_product.name = @name

    cloned_product
  end

  def to_s
    super + ", name: #{@name}"
  end
end

# test

original_product = Product.new

cloned_product = original_product.make_prototype

puts "original product: #{original_product}"
puts "cloned product : #{cloned_product}"
