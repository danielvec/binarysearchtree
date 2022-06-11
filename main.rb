# node class with attributes for data, left and right children
class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end


class Tree
  attr_accessor :root

  def initialize(array)
    build_tree(array)
  end

  def build_tree(array)
    array = array.sort.uniq
    return array if array.length < 2

    @root = Node.new(array[array.length/2])
    @root.left = build_tree(array[0...array.length/2])
    @root.right = build_tree(array[array.length/2+1...array.length])
    @root
  end
end

t = Tree.new([1,3,7,2,8,4,5])