# domain-function.bsh
# better than visitor
# http://blogs.concedere.net:8080/blog/discipline/java/?permalink=Domain-Function-Pattern.html

class Employee
  def initialize(type, name)
    @type = type
    @name = name
  end

  attr_reader :type

  def to_s
    @name
  end
end

class EmployeeDomainFunction
  def call(employee); end
end

class VacationPlanner < EmployeeDomainFunction
  def call(employee)
    case employee.type
    when :contractor
      puts 'Vacation planning for Contractor: 0'
    when :executive
      puts 'Vacation planning for Executive: 90'
    when :manager
      puts 'Vacation planning for Manager: 45'
    when :secretary
      puts 'Vacation planning for Secretary: 15'
    when :engineer
      puts 'Vacation planning for Engineer: 10'
    else
      raise "unknown employee type: #{employee.type}"
    end
  end
end


vacation_planner = VacationPlanner.new

employees = []

employees << Employee.new(:contractor, 'contractor 1')
employees << Employee.new(:contractor, 'contractor 2')
employees << Employee.new(:executive, 'executive 1')
employees << Employee.new(:manager, 'manager 1')
employees << Employee.new(:secretary, 'secretary 1')
employees << Employee.new(:engineer, 'engineer 1')
employees << Employee.new(:engineer, 'engineer 2')

puts "employees: #{employees.join(', ')}"

puts 'Vacation planning:'

employees.each do |employee|
  vacation_planner.call(employee)
end

