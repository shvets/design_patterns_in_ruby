# chain-of-responsibility.bsh

# Avoid coulpling the sender of a request to it's receiver by giving more than
# one object a chance to handle the request. Chain the receiving object and pass
# the request along the chain until an object handles it.

# 1. type interface

class Handler
  def handle
  end

  def next_handler=(handler)
  end
end

# 2. type implementation

class MyHandler < Handler
  def initialize(name)
    @name = name
  end
  
  def handle
    puts "Handling by " + @name + "."

    if(@next_handler != nil)
      @next_handler.handle
    end
  end

  def next_handler=(next_handler)
    @next_handler = next_handler
  end
end

# 3. test

handler1 = MyHandler.new("handler1")
handler2 = MyHandler.new("handler2")
handler3 = MyHandler.new("handler3")
handler4 = MyHandler.new("handler4")
handler5 = MyHandler.new("handler5")

handler1.next_handler = handler2
handler2.next_handler = handler5
handler5.next_handler = handler3
handler3.next_handler = handler4

handler1.handle