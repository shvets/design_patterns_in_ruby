# domain-function.rb
# better than visitor 
# http://blogs.concedere.net:8080/blog/discipline/java/?permalink=Domain-Function-Pattern.html

class Employee
  def initialize(name)
    @name = name
    @type = nil
  end

  def type
    @type
  end

  def to_s
    @name
  end
end

class Contractor < Employee
  def initialize(name)
    super
  end
end

class Executive < Employee
  def initialize(name)
    super
  end
end

class Manager < Employee
  def initialize(name)
    super
  end
end

class Secretary < Employee
  def initialize(name)
    super
  end
end

class Engineer < Employee
  def initialize(name)
    super
  end
end

class EmployeeDomainFunction
  def call(employee)
    if (employee.kind_of? Contractor)
      call_local(employee, :contractor)
    elsif (employee.kind_of? Executive)
      call_local(employee, :executive)
    elsif (employee.kind_of? Manager)
      call_local(employee, :manager)
    elsif (employee.kind_of? Secretary)
      call_local(employee, :secretary)
    elsif (employee.kind_of? Engineer)
      call_local(employee, :engineer)
    else
      raise Exception("unknown employee type: " + e.class.name);
    end
  end

  protected

  def call_local(employee, type)
  end
end

class VacationPlanner < EmployeeDomainFunction
  protected

  def call_local(employee, type)
    if(type == :contractor)
      puts "Vacation planning for Contractor: " + 0.to_s
    elsif(type == :executive)
      puts "Vacation planning for Executive: " + 90.to_s
    elsif(type == :manager)
      puts "Vacation planning for Manager: " + 45.to_s
    elsif(type == :executive)
      puts "Vacation planning for Secretary: " + 15.to_s
    elsif(type == :executive)
      puts "Vacation planning for Engineer: " + 10.to_s
    end

  end
end


vacation_planner = VacationPlanner.new

employees = []

employees << Contractor.new("contractor 1")
employees << Contractor.new("contractor 2")
employees << Executive.new("executive 1")
employees << Manager.new("manager 1")
employees << Secretary.new("secretary 1")
employees << Engineer.new("engineer 1")
employees << Engineer.new("engineer 2")

puts "employees: " + employees.join(', ')

puts "Vacation planning:"

employees.each do |employee|
  vacation_planner.call(employee)
end

