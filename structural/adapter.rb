# adapter.rb

# Converst the interface of a class into another intrerface clients expect.
# Lets classes work together that couldn't otherwise because of incompatible interfaces.

# 1. existing layout

class ClientItem
  def some_operation
  end
end

class MyClientItem < ClientItem
  def some_operation
     puts "some operation"
  end
end

class Client  
  def process(item)
    item.some_operation
  end
end

# 2. class that creates conflict (adaptee): we cannot pass type in client's process() method.

class OtherItem # adaptee
  def other_operation
    puts "other operation"
  end
end

# 3. adaptation

class ClientItemAdapter < ClientItem # adapter
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

# client.process(OtherItem.new) # OtherItem does not conform CientItem protocol

client.process(ClientItemAdapter.new) # OtherItem is adapted to CientItem protocol through adapter

other_item = OtherItem.new

class << other_item
  def some_operation
    puts "some operation for this instance"
  end
end

client.process(other_item)  # OtherItem is adapted to CientItem protocol with the help of odifying instance behavior

