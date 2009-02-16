# states.rb

# Allow an object to alter it's behavior when it's internal state changes.
# The object will appear to change it's class.

# 1. state type and it's implementations

class State
  def handle
  end
end

class MyState1 < State
  def handle
    puts "handle1"
  end
end

class MyState2 < State
  def handle
    puts "handle2"
  end
end


# 2. context's type and it's implementation

class Context 
  def state=(state)
  end

  def request
  end
end

class MyContext < Context

  def state=(state) 
    @state = state
  end

  def request 
    @state.handle
  end
end
  


# 3. test

context = MyContext.new

state1 = MyState1.new
state2 = MyState2.new

context.state = state1
context.request

context.state = state2
context.request
