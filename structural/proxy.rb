# proxy.rb

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

# 3.type proxy implementation

class SubjectProxy < Subject

  def initialize(subject)
    @subject = subject
  end

  def process
    @subject.process
  end
end

class DynamicSubjectProxy 

  def initialize(subject)
    @subject = subject
  end

#  def process
#    @subject.process
#  end
  def method_missing(name, *args)
    puts("Delegating #{name} message to subject.")
  
    @subject.send(name, *args)
  end
end


# 4. test 

proxy = SubjectProxy.new(MySubject.new)

proxy.process

dynamic_proxy = DynamicSubjectProxy.new(MySubject.new)

dynamic_proxy.process
