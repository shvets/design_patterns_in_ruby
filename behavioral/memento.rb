# memento.rb

# Without violating encapsulation, capture and externalize an object's internal state
# so that the object can be restored to this state later.

# 1. This class don't want to reveal it's internal state and delegates presistance work to memento
#    object. This object should have access to private properties of enclosed class.

class Memento 
  def initialize(originator, memento_state)
    @originator = originator
    @memento_state = memento_state
  end

  def restore_memento
    @originator.state = @memento_state
  end
end

class Originator
  def initialize()
    @state = nil
  end

  def state=(state)
    @state = state
  end

  def print_state
    puts @state
  end

  def create_memento
    Memento.new(self, @state)
  end

  def restore_memento(m)
    if (m.kind_of? Memento)
      m.restore_memento
    end
  end
end


# 2. Caretaker holds previously creted mementos: storage 

class Caretaker
  def initialize
    @saved_states = []
  end

  def add_memento(memento)
    @saved_states << memento
  end
 
  def get_memento(index)
    @saved_states[index]
  end
end

# 3. test

caretaker = Caretaker.new

originator = Originator.new

originator.state= "State1"
print "step1:"
originator.print_state

originator.state = "State2"
print("step2: ")
originator.print_state

caretaker.add_memento( originator.create_memento )
print("step3: ")
originator.print_state

originator.state = "State3"
print("step4: ")
originator.print_state

caretaker.add_memento( originator.create_memento )
print("step5: ")
originator.print_state

originator.state = "State4"
print("step6: ")
originator.print_state

originator.restore_memento( caretaker.get_memento(1) )
print("step7: ")
originator.print_state
