# iterator2.rb

# 1. iterator implementation (original collection is initialized externally)

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

# 2. test

array = ['e1', 'e2', 'e3', 'e4']

iterator = ExternalIterator.new(array)

while iterator.has_next?
  puts iterator.next.to_s
end
