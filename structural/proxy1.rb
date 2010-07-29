# proxy1.rb

# Provides a surrogate or placeholder for another object to control access to it.

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

class SubjectProxy < Subject

  def initialize(subject)
    @subject = subject
  end

  def process
    puts("Delegating 'process' message to subject.")
    
    @subject.process
  end
end


# 4. test 

proxy = SubjectProxy.new(MySubject.new)

proxy.process
