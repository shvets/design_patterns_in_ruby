# mvc.bsh

# 1. observer and observable interfaces (see Observer pattern)

class Observer
  def update(key, value); end
end

# see Observer pattern
class Observable
  def add_observer(observer); end

  def remove_observer(observer); end

  def notify_observers(key, value); end
end

# 2. Model, Controller-Mediator-Observer, View

class Model
  def value(key); end

  def set_data(key, value); end

  def get_observable; end
end

class Controller < Observer
  # Binds a model to this controller. Once added, the controller will listen for all
  # model property changes and propagate them on to registered views. In addition,
  # it is also responsible for resetting the model properties when a view changes state.
  def add_model(model); end

  def remove_model(model); end

  # Binds a view to this controller. The controller will propagate all model property
  # changes to each view for consideration.
  def add_view(view); end

  def remove_view(view); end

  def models; end

  def views; end

  def operation1(value); end

  def operation2(value); end
end

class View < Observer
  def set_controller(controller); end
end

# 3. Implementation of observable

class AbstractObservable < Observable
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers(key, value)
    @observers.clone.each { |observer| observer.update(key, value) }
  end
end

# 4. implementations

class MyModel < Model
  def initialize
    @observable = AbstractObservable.new
    @data = {}
  end

  def observable
    @observable
  end

  # model implementation

  def value(key)
    @data[key]
  end

# mutator
  def set_data(key, value)
    @data[key] = value

    @observable.notify_observers(key, value) # notify about state change
  end

  def to_s
    "model: #{@data}"
  end
end

# this controller mediates all changes in model and propagates them to
# all registered views through update() method
class AbstractController < Controller
  # controller behavior

  def initialize
    @models = []
    @views = []
  end

  def add_model(model)
    @models << model

    model.observable.add_observer(self)
  end

  def remove_model(model)
    @models.remove(model)

    model.observable.remove_observer(self)
  end

  def add_view(view)
    @views << view

    view.controller = self
  end

  def remove_view(view)
    @views.remove(view)
  end

  def models
    @models
  end

  def views
    @views
  end

  # observer behavior

  # This method represents changes model -> views

  # Use this to observe property changes from registered models
  # and propagate them on to all registered views.
  def update(key, value)
    @views.each { |view| view.update(key, value) }
  end

  # This method represents changes view -> models

  # Convenience method that subclasses can call upon to fire off property changes
  # back to the models. This method used reflection to inspect each of the model
  # classes to determine if it is the owner of the property in question. If it
  # isn't, a NoSuchMethodException is throws (which the method ignores).
  def set_model_property(key, value)
    @models.each { |model| model.set_data(key, value) }
  end
end

class MyView < View
  def controller=(controller)
    @controller = controller
  end

  def property1=(value)
    @property1 = value

    @controller.operation1(value)
  end

  def property2=(value)
    @property2 = value

    @controller.operation2(value)
  end

  def update(key, value)
    if key == :property1
      @property1 = value
    end

    if key == :property2
      @property2 = value
    end
  end

  def to_s
    "view[property1: #{@property1}; property2: #{@property2}]"
  end
end

class MyController < AbstractController
  # implementing Mediator

  def operation1(value)
    set_model_property(:property1, value)
  end

  def operation2(value)
    set_model_property(:property2, value)
  end
end

# 5. test

def print_controller(controller)
  i = 1
  controller.models.each { |model| puts "model#{i}: #{model}"; i = i+1 }

  i = 1
  controller.views.each { |view| puts "view#{i}: #{view}"; i = i+1 }
end

controller1 = MyController.new

model1 = MyModel.new

view11 = MyView.new
view12 = MyView.new

controller1.add_model(model1)
controller1.add_view(view11)
controller1.add_view(view12)

controller2 = MyController.new

model2 = MyModel.new
model3 = MyModel.new

view21 = MyView.new
view22 = MyView.new
view23 = MyView.new

controller2.add_model(model2)
controller2.add_model(model3)
controller2.add_view(view21)
controller2.add_view(view22)
controller2.add_view(view23)

puts '1. changes in model1'

model1.set_data(:property1, '555')

print_controller(controller1)

puts '2. changes in view12'

view12.property2 = '777'

print_controller(controller1)

puts '3. changes in model3'

model3.set_data(:property1, '111')

print_controller(controller2)

puts '4. changes in view23'

view23.property1 = '222'
view23.property2 = '333'

print_controller(controller2)
