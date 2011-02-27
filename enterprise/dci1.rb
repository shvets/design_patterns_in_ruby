# dci1.rb
# Data-Context-Interaction pattern

# The code for separate use case in OO is typically spread out between lots of differen classes.
# To understand how the code works, you must also know the relationships between objects in runtime.
# These relationships aren't set in code, they depend on the situation.
# What DCI proposes is that code for a given use-case is separated out from the classes and put into
# a different artifact called context. Objects of different classes can enter into a relationship in this
# context and take part in interaction where they have different roles.

# Suggestions:
#
# a) keep core model classes very thin
# b) keep additional logic/behaviour in roles
# c) do not do class oriented programming, do object oriented programming

# 1. Data
class DataObject # thin data/model
  attr_accessor :basic_property
end

# 2. Roles: broken into pieces functionality
module Role1
  attr_accessor :role1_property
end

module Role2
  attr_accessor :role2_property
end

# 3. The place where role is assigned to data/model.
# We do it dynamically at run-time, on object, not class declaration level.

class Context # or use case
  def initialize data
    @data = data
  end

  def execute
    p @data.basic_property # OK

    begin
      @data.role1_property 
    rescue
      p "Error: role1_property is not available yet"
    end

    @data.extend Role1
    
    @data.role1_property = "test_role1"
    p @data.role1_property
  end
end

class UseCase # or context
  def initialize data
    @data = data
  end

  def execute
    p @data.basic_property # OK

    begin
      @data.role2_property
    rescue
      p "Error: role2_property is not available yet"
    end

    @data.extend Role2

    @data.role2_property = "test_role2"
    p @data.role2_property
  end
end

# 4. Actual Program

class Interaction
  def initialize
    @data = DataObject.new
    @data.basic_property = "test_basic"
  end

  def interact
    context = Context.new @data
    context.execute

    use_case = UseCase.new @data
    use_case.execute
  end
end

interaction = Interaction.new
interaction.interact