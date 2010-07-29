# singleton3.rb

# Usually you have to avoid using Singeton, because it's not possible to mock (and consequently test) it. 
#
# This example is trying to replace Singleton pattern with interface inheritance and dependency injection.
# Now we can mock the singleton. 

# 1. Define singleton. 

class Singleton
  def operation
  end
end

# 2. Singleton implementation.

class MySingleton < Singleton
  def operation
    puts "operation"
  end
end

# 3. Class that uses the singleton object (we should be able to set it up from outside).

class SingletonUser
  def initialize(singleton)
    @singleton = singleton
  end

  def do_something
    @singleton.operation
  end

end

# 4. Create mock object for the singleton.

class MockSingleton < Singleton

  def operation
    puts "mock operation"
  end

end


# 5. test

class SingletonTest
  def test_singleton
    singleton = MockSingleton.new

    singleton_user = SingletonUser.new(singleton)
    
    singleton_user.do_something
    
    # assertions
  end
end

tester = SingletonTest.new

tester.test_singleton

