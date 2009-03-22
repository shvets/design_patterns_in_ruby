# observer2.rb

# Define a one-to-many dependency between objects so that when one object
# changes state, all it's dependents are notified and updated automatically

require 'observer'

# 1. observer

class Observer
  def initialize(name) 
    @name = name
  end

  def update(value)
    puts "updated " + @name + ". New value: " + value
  end
end

# 2. Observable is imported from 'observer' module

# 3. test

class Tester
  include Observable

  def property= property
    @property = property
  
    changed
    notify_observers(property)
  end
end

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")

observer4 = Proc.new {}

observer4.instance_eval do
  def update(value)
    puts "updated from lambda (update is :#{value})"
  end
end

tester = Tester.new

tester.add_observer observer1
tester.add_observer observer2
tester.add_observer observer3
tester.add_observer observer4

tester.property = 'red'

puts '----------'

tester.delete_observer observer3

tester.property = 'green'
