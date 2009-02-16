# observer2.rb

# Define a one-to-many dependency between objects so that when one object
# changes state, all it's dependents are notified and updated automatically.

require 'observer'

# 1. observer

class Observer
  def initialize(name) 
    @name = name;
  end

  def update 
    puts "updated " + @name
  end
end

# 3. Observable is imported from 'observer' module

class Tester
  include Observable
end

# 4. test

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")

tester = Tester.new

tester.changed

tester.add_observer observer1
tester.add_observer observer2
tester.add_observer observer3

tester.notify_observers

puts '----------'

tester.delete_observer observer3

tester.changed

tester.notify_observers
