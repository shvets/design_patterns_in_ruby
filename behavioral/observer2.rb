# observer2.rb

# Slight modification of previous example with metaprogramming to wrap methods
# that needs to be observed.

# 1. observer 

class Observer
  def initialize(name) 
    @name = name
  end

  def update(value)
    puts "updated " + @name + ". New value: " + value
  end
end

# 2. Observable, serves as a container for observers and takes care of notifying them

module ObservableClassMethods
  def act_as_observable *list
    list.each do |observable|
      method_name = "#{observable.to_s}="
      no_callback_method_name = "no_callback_#{observable.to_s}="

      alias_method no_callback_method_name, method_name 

      define_method method_name do |value|
        send no_callback_method_name, value

        notify_observers(value)
      end
    end
  end
end

module Observable 
  def self.included(base)
    base.extend(ObservableClassMethods)
  end
  
  def initialize
    @observers = []
  end

  def <<(observer) 
    @observers << observer
  end
  
  def >>(observer) 
    @observers.delete(observer)
  end

  protected

  def notify_observers(value) 
    @observers.clone.each do |observer| 
      observer.update(value) if observer.kind_of? Observer
      observer.call(value)  if observer.kind_of? Proc
    end
  end
end

# 3. Implementation of the observer
class MyObservable 
  include Observable
  
  attr_accessor :my_property
  
  # def my_property=(my_property)
  #   @my_property = my_property
  #   
  #   notify_observers(my_property)
  # end
  act_as_observable :my_property
end

# 4. test

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")
observer4 = lambda { |value| puts "updated from lambda (update is :#{value})" }

my_observable = MyObservable.new

my_observable << observer1
my_observable << observer2
my_observable << observer3
my_observable << observer4

my_observable.my_property = 'red'

puts 'Deleting observer 3 ----------'

my_observable >> observer3

my_observable.my_property = 'green'
