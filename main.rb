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
    @root = build_tree(array)
  end

  def build_tree(array)
    array = array.sort.uniq
    return if array.empty?

    root = Node.new(array[array.length/2])
    root.left = build_tree(array[0...array.length/2])
    root.right = build_tree(array[array.length/2+1...array.length])

    root
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    if root.data > value
      root.left = insert(value, root.left)
    elsif root.data < value
      root.right = insert(value, root.right)
    end

    root
  end

end

t = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p t.root
t.insert(10000)
p t.pretty_print