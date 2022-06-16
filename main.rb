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

  def delete(value, root = @root)
    # base case
    return nil if root.nil?

    # recursively go through tree until value is reached
    if root.data > value
      root.left = delete(value, root.left)
      root
    elsif root.data < value
      root.right = delete(value, root.right)
      root
    else
      # check if root has one child
      if root.left.nil?
        temp = root.right
        nil
        temp
      elsif root.right.nil?
        temp = root.left
        nil
        temp
      elsif !root.right.nil? && !root.left.nil?
        #find in order successor
        temp = root.right
        until !temp.left.nil?
          temp = temp.right
        end
        temp = temp.left
        #replace root with successor
        root.data = temp.data
        #delete previous successor node
        root.right = delete(temp.data, root.right)
        root
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

t = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
t.insert(10000)
t.delete(1)
t.delete(67)
p t.pretty_print