# dci2.rb
# Data-Context-Interaction pattern

require 'rubygems'
require 'mixology'

# 1. Data (or model)
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

class Context # or use case (or controller)
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

    @data.mixin Role1

    @data.role1_property = "test_role1"
    p @data.role1_property

    @data.unmix Role1

    begin
      @data.role1_property
    rescue
      p "Error: role1_property is not available again"
    end

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

    @data.mixin Role2

    @data.role2_property = "test_role2"
    p @data.role2_property

    @data.unmix Role2

    begin
      @data.role2_property
    rescue
      p "Error: role2_property is not available again"
    end
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
