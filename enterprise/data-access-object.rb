# data-access-object.bsh

# 1.

class TransferObject
  def data(key)
  end

  def set_data(key, value)
  end
end

class TransferObjectDAO
  def set_data_source(dataSource)
  end

  def create
  end

  def update(transfer_object)
  end

  def delete(transfer_object)
  end

  def find(id)
  end

  def find_all
  end
end

class DataSource
  def generate_next_id
  end

  def execute_command(command, param)
  end
end

class TransferObjectDAOFactory
  def transfer_object_dao
  end
end

# 2.

class MyTransferObject < TransferObject
  def initialize
    @data = {}
  end

  def data(key)
    @data[key]
  end

  def set_data(key, value)
    @data[key] = value
  end

  def to_s
    @data.to_s
  end
end

class MyDataSource < DataSource
  def initialize
    @generated_id = 0

    @objects = []
  end

  def generate_next_id
    @generated_id = @generated_id + 1
  end

  def execute_command(command, param=nil)
    result = nil

    if(command == :insert)
      result = (@objects << param)
    elsif(command == :update)
      index = @objects.index(param)
      @objects.delete_at(index)
      @objects.insert(index, param)

      result = true
    elsif(command == :delete)
      result = (@objects.delete(param))  
    elsif(command == :find)
      id = param
      
      @objects.each do |transfer_object|
        current_id = transfer_object.data("id")

        if(current_id == id)
          result = transfer_object

          break
        end
      end
    elsif(command == :find_all)
      result = @objects
    end

    result
  end
end

class MyTransferObjectDAO < TransferObjectDAO

  def data_source=(data_source)
    @data_source = data_source
  end

  def create
    transfer_object = MyTransferObject.new

    id = @data_source.generate_next_id

    transfer_object.set_data("id", id)

    @data_source.execute_command(:insert, transfer_object)

    id
  end

  def update(transfer_object)
    @data_source.execute_command(:update, transfer_object)
  end
  
  def delete(transfer_object)
    @data_source.execute_command(:delete, transfer_object)
  end

  def find(id)
    @data_source.execute_command(:find, id)
  end

  def find_all
    @data_source.execute_command(:find_all)
  end
end

class MyTransferObjectDAOFactory < TransferObjectDAOFactory

  def initialize(data_source)
    @data_source = data_source
  end

  def transfer_object_dao
    transfer_object_dao = MyTransferObjectDAO.new
    
    transfer_object_dao.data_source = @data_source
    
    transfer_object_dao
  end
end


# test - or business object, or client

dataSource = MyDataSource.new
factory = MyTransferObjectDAOFactory.new(dataSource)

dao = factory.transfer_object_dao

# create a new domain object
new_id = dao.create

# Find a domain object.
o1 = dao.find(new_id)

puts "o1: " + o1.to_s

# modify the values in the Transfer Object.
o1.set_data("address", "a1")
o1.set_data("email", "em1")

# update the domain object using the DAO
dao.update(o1)

puts "o1: " + o1.to_s

list = dao.find_all

puts "list before delete: " + list.join(', ')

# delete a domain object
dao.delete(o1)

puts "list after delete: " + list.join(', ')
