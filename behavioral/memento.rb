# memento.bsh

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
  def initialize
    @state = nil
  end

  def state=(state)
    @state = state
  end

  def state_to_s
    @state.to_s
  end

  def create_memento
    Memento.new(self, @state)
  end

  def restore_memento(m)
    m.restore_memento
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
 
  def [](index)
    @saved_states[index]
  end
end

# 3. test

caretaker = Caretaker.new
originator = Originator.new

originator.state = "State1"
puts "step1: " + originator.state_to_s

originator.state = "State2"
puts "step2: " + originator.state_to_s

caretaker.add_memento(originator.create_memento())
puts "step3: " + originator.state_to_s

originator.state = "State3"
puts "step4: "+ originator.state_to_s

caretaker.add_memento(originator.create_memento())
puts "step5: " + originator.state_to_s

originator.state = "State4"
puts "step6: " + originator.state_to_s

originator.restore_memento(caretaker[1])
puts "step7: " + originator.state_to_s
