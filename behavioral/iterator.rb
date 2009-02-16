# iterator.rb

# Provides a way to access the elements of an aggregate object sequentially without exposing 
# its underlying representation.

# 1. external iteator

class ExternalIterator
  def initialize(array)
    @array = Array.new(array)
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def next
    value = @array[@index]

    @index += 1

    value
  end

  def current_element
    @array[@index]
  end
end

# 2. internal iteator

module InternalIterator
  def initialize()
    @array = []
  end

  def each()
    copy = Array.new(@array)

    i = 0

    while i < copy.length
      if block_given?
        yield(copy[i])
      end

      i += 1
    end
  end
end

class TestInternalIterator
  include InternalIterator

  def initialize
    super

    @array = ['i1', 'i2', 'i3', 'i4']
  end
end

# 3. Iterator with help of Enumerable

class Element
  attr_accessor :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  # this method is important for Enumerable
  def <=>(other)
    value <=> other.value
  end
end

class TestEnumerable
  include Enumerable

  def initialize
    @array = []
  end

  def each(&block)
    @array.each(&block)
  end

  def <<(element)
    @array << element
  end
end

# test

array = ['e1', 'e2', 'e3', 'e4']

e_it = ExternalIterator.new(array)

while e_it.has_next?
  puts e_it.next.to_s
end


i_it = TestInternalIterator.new()

i_it.each {|e| puts e.to_s}


test = TestEnumerable.new

el = Element.new("n2", 2001)

test << Element.new("n1", 1)
test << el
test << Element.new("n3", 22)
test << Element.new("n4", 64)

puts "Has n2: " + test.include?(el).to_s

puts "All elements have value >= 10: " + (test.all? {|e| e.value >= 10}).to_s

puts "Has any element with value >= 2000: " + (test.any? {|e| e.value > 2000}).to_s
