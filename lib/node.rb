# node class with attributes for data, left and right children
class Node
    attr_accessor :data, :left, :right
  
    def initialize(data = nil, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end
  end
  