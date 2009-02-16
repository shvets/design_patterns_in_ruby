# bridge.rb

# Decouples an abstraction from it's implementation so that the two can vary independently.

# 1. implementor

class Material 
  def make
  end
end

# 2. concrete implementors

class MyMaterial1 < Material 
  def make
    puts "make: my material 1"
  end
end

class MyMaterial2 < Material 
  def make
    puts "make: my material 2"
  end
end

# 3. abstraction

class Product 
  def taste
  end
end

# 4. refined abstraction

class MyProduct < Product 
  def initialize(material)  # injecting implementor
    @material = material
  end

  def taste
    @material.make
  end

end

# 5. test (bridge)

material1 = MyMaterial1.new

product1 = MyProduct.new(MyMaterial1.new)
product2 = MyProduct.new(MyMaterial2.new)

product1.taste
product2.taste

