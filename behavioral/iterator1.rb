# iterator1.rb

# Provides a way to access the elements of an aggregate object sequentially without exposing 
# its underlying representation.

# 1. iterator implementation (original collection is initialized internally)

module Iterator
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

class MyIterator 
  include Iterator

  def initialize
    super

    @array = ['e1', 'e2', 'e3', 'e4']
  end
end


# test

iterator = MyIterator.new()

iterator.each {|e| puts e.to_s}
