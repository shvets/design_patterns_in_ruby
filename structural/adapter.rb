# adapter.rb

# Convert the interface of a class into another interface clients expect.
# Lets classes work together that couldn't otherwise because of incompatible interfaces.

# 1. existing layout

class ClientItem
  def some_operation
  end
end

class MyClientItem < ClientItem
  def some_operation
    puts 'some operation'
  end
end

class Client
  def process(item)
    item.some_operation
  end
end

# 2. class that creates conflict (adaptee): we cannot pass it in client's process() method.

# adaptee
class OtherItem
  def other_operation
    puts 'other operation'
  end
end

# 3. adaptation

# adapter
class OtherItemAdapter < ClientItem
  def initialize
    @other_item = OtherItem.new
  end

  # actual adaptation
  def some_operation
    @other_item.other_operation
  end
end

# 4. test

client = Client.new

client.process(MyClientItem.new) # OK

# client.process(OtherItem.new) # OtherItem does not conform ClientItem protocol

client.process(OtherItemAdapter.new) # OtherItem is adapted to ClientItem protocol through adapter

# here we adapt incompatible interface "on the fly" using ruby ability to dynamically
# add missing method to the class.

other_item = OtherItem.new

class << other_item
  def some_operation
    puts 'some operation for this instance (v1)'
  end
end

client.process(other_item)

other_item2 = OtherItem.new

def other_item2.some_operation
  puts 'some operation for this instance (v2)'
end

client.process(other_item2)

# or adding this method directly to the class by opening it:
class OtherItem
  def some_operation
    puts 'some operation for this instance (v3)'
  end
end

client.process(OtherItem.new)
