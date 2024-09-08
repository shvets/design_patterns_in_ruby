# factory-method.rb

# Defines an interface for creating an object, but let subclasses decide which
# class to instantiate. Lets a class to defer instantiation to subclasses.

# 1. common type interface

class Shape
  def draw; end
end

# 2. implementations of common type interface

class Line < Shape
  def draw
    puts 'line'
  end
end

class Square < Shape
  def draw
    puts 'square'
  end
end

# 3. Creator class for various types

class ShapeCreator

  # factory methods

  def create_line
    Line.new
  end

  def create_square
    Square.new
  end

  # or universal factory method (parameterized factory method)

  def create_shape(type)
    if type == :line
      Line.new
    elsif type == :square
      Square.new
    end
  end

end

# 4. test

shape_creator = ShapeCreator.new

shape1 = shape_creator.create_line
shape2 = shape_creator.create_square
shape3 = shape_creator.create_shape :line

shape1.draw
shape2.draw
shape3.draw

