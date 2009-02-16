# domain-function.bsh
# better than visitor 
# http://blogs.concedere.net:8080/blog/discipline/java/?permalink=Domain-Function-Pattern.html

class Employee
  def initialize(type, name)
    @type = type
    @name = name
  end

  def type
    @type
  end

  def to_s
    @name
  end
end


class EmployeeDomainFunction
  def call(employee)
  end
end

class VacationPlanner < EmployeeDomainFunction
  def call(employee)
    if(employee.type == :contractor)
      puts "Vacation planning for Contractor: " + 0.to_s
    elsif(employee.type == :executive)
      puts "Vacation planning for Executive: " + 90.to_s
    elsif(employee.type == :manager)
      puts "Vacation planning for Manager: " + 45.to_s
    elsif(employee.type == :secretary)
      puts "Vacation planning for Secretary: " + 15.to_s
    elsif(employee.type == :engineer)
      puts "Vacation planning for Engineer: " + 10.to_s
    else
      raise "unknown employee type: " + employee.type
    end

  end
end


vacation_planner = VacationPlanner.new

employees = []

employees << Employee.new(:contractor, "contractor 1")
employees << Employee.new(:contractor, "contractor 2")
employees << Employee.new(:executive, "executive 1")
employees << Employee.new(:manager, "manager 1")
employees << Employee.new(:secretary, "secretary 1")
employees << Employee.new(:engineer, "engineer 1")
employees << Employee.new(:engineer, "engineer 2")

puts "employees: " + employees.join(', ')

puts "Vacation planning:"

employees.each do |employee|
  vacation_planner.call(employee)
end

