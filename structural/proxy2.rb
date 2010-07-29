# proxy2.rb

# Provides proxy implementation with ruby's method_missing.

# 1. type interface

class Subject
  def process
  end
end

# 2. type implementation

class MySubject < Subject
  def process
    puts "my process"
  end
end

# 3. type proxy implementation

class DynamicSubjectProxy 

  def initialize(subject)
    @subject = subject
  end

  def method_missing(name, *args)
    puts("Delegating '#{name}' message to subject.")
  
    @subject.send(name, *args)
  end
end


# 4. test 

dynamic_proxy = DynamicSubjectProxy.new(MySubject.new)

dynamic_proxy.process
