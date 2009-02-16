# map-reduce.bsh

# http://www.theserverside.com/tt/knowledgecenter-tc/knowledgecenter-tc.tss?l=MapReduce
# http://www.theserverside.com/tt/articles/article.tss?l=MapReduceRedux

# MapReduce is a distributed programming model intended for processing massive amounts of data in large clusters, 
# developed by Jeffrey Dean and Sanjay Ghemawat at Google. The implementation of MapReduce separates the business
# logic from the multi-processing logic. 
#
# MapReduce is implemented as two functions, Map which applies a function to all the members of a collection and
# returns a list of results based on that processing, and Reduce, which collates and resolves the results from 
# two or more Maps executed in parallel by multiple threads, processors, or stand-alone systems. Both Map() 
# and Reduce() may run in parallel, though not necessarily in the same system at the same time.

# 1. functors interfaces

class MapFunctor
  def function(object)
  end
end

class ReduceFunctor
  def function(list, object)
  end
end

# 2. map-reduce interface

class MapReduce
  def map(map_functor, list)
  end

  def reduce(reduce_functor, list, init_list)
  end
end


# 3. implementations

class MapFunctorImpl < MapFunctor
 def function(object) # copier
   object
 end
end

class ReduceFunctorImpl < ReduceFunctor
 
 def function(list, object) # duplication reducer
   if(!list.include? object)
     list << object
   end

   list
 end

end

class MapReduceImpl < MapReduce

  def map(map_functor, list)
    intermediate_result = []

    list.each do |element|
      result = map_functor.function(element)

      intermediate_result << result
    end

    intermediate_result
  end

  def reduce(reduce_functor, list, init_list)
    result = init_list

    list.each do |value|
      result = reduce_functor.function(result, value)
    end

    result
  end

end

# 4. test

# input data

bucket1 = [ "1", "2", "3", "4", "5" ]

bucket2 = [ "6", "4", "8", "5", "10" ]

# Business logic is concentrated in functors

map_functor = MapFunctorImpl.new
reduce_functor = ReduceFunctorImpl.new

# Different instances of map-reduce objects. They can be used for "map" or "reduce" operations.

map_reduce1 = MapReduceImpl.new
map_reduce2 = MapReduceImpl.new
map_reduce3 = MapReduceImpl.new

intermediate_data1 = map_reduce1.map(map_functor, bucket1)
intermediate_data2 = map_reduce2.map(map_functor, bucket2)

final_data = map_reduce3.reduce(reduce_functor, intermediate_data2, intermediate_data1)

puts "bucket1: " + bucket1.join(', ')
puts "bucket2: " + bucket2.join(', ')

puts "intermediate data 1: " + intermediate_data1.join(', ')
puts "intermediate data 2: " + intermediate_data2.join(', ')

puts "final data: " + final_data.join(', ')
