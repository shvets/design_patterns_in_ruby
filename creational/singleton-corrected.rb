# singleton-corrected.rb

# Trying to replcae Singleton pattern with interface inheritance and dependency injection.
# Now we can mock the singleton. 

# - Reduce hidden coupling;
# - Allow testability;
# - Allow subclassing;
# - Make construction and use flexible;

# 1. Rediefine singleton. 

class Singleton
  def operation
  end
end

class MySingleton < Singleton
  def operation
    puts "operation"
  end
end

# 2. Class that uses the singleton object (we should be able to set it up from outside).

class SingletonUser
  def initialize(singleton)
    @singleton = singleton
  end

  def do_something
    @singleton.operation
  end

end

# 3. Mock object for the singleton and the test

class MockSingleton < Singleton

  def operation
    puts "mock operation"
  end

end

class SingletonTest
  def test_singleton
    singleton = MockSingleton.new

    singleton_user = SingletonUser.new(singleton)
    
    singleton_user.do_something
    
    # assertions
  end
end

# 4. test

tester = SingletonTest.new

tester.test_singleton


