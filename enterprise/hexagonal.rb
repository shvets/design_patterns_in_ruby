# 1. Have some database implementation (storage device)

class SomeDatabase

  def save model
    puts "Model #{model} saved."
  end

end

# 2. Have some Web UI implementation (interaction device)

class WebUI
  def good_request
    "some_name"
  end

  def bad_request
    ""
  end
end

# 3. Create model

class SomeModel

  # put some attributes here

  attr_accessor :name

  def initialize name
    @name = name
  end

  def valid?
    not name.nil? and name.strip.size > 0
  end

  def to_s
    name.nil? ? "unknown" : name
  end
end

# 4. Create repository for the model
#    - decouples model from storage device (database)

class SomeModelRepository

  def save model
    # save model in database
    SomeDatabase.new.save model
  end

end

# 5. Create Use Case Service (coordinator)
#    - decouples model from controller
#    - has business/decision logic
#    - should not have any computation or state management

class SomeUseCaseService
  attr_reader :repository, :controller

  def initialize repository, controller
    @repository = repository
    @controller = controller
  end

  def create_some_model params
    model = SomeModel.new params[:name]

    if model.valid? # decision logic
      repository.save(model)
      controller.model_creation_succeeded model
    else
      controller.model_creation_failed model
    end
  end
end

# 6. Create controller
#    - decouples model from interaction device (Web UI)
#    - should not contain business logic (moved to use case service)
#    - could have more than one use case service (1-n)
#    - acts as listener for use case service: has callback methods on success or failure

class SomeController

  def create_some_model params
    # 1. Create repository
    repository = SomeModelRepository.new

    # 2. Create use case service
    service = SomeUseCaseService.new repository, self

    # 3. Create model
    service.create_some_model params
  end

  # successful path
  def model_creation_succeeded model
    puts "Model #{model} was created successfully."
  end

  # failure path
  def model_creation_failed model
    puts "Model #{model} creation failed."
  end

end

# 7. Code example

controller = SomeController.new

# Successful model creation
controller.create_some_model({name: WebUI.new.good_request})

# Failed model creation
controller.create_some_model({name: WebUI.new.bad_request})