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

  def find(value, root = @root)
    if root.data > value
      root.left = find(value, root.left)
    elsif root.data < value
      root.right = find(value, root.right)
    elsif root.data == value
      puts root
    else 
      puts "not found"
    end
  end

  def level_order(root = @root)
    queue = [root]
    order = []
    until queue.empty?
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      yield(queue.shift.data) if block_given?
      order << queue.shift.data unless block_given?
    end
    puts order unless block_given?
  end

  def recursive_level_order(root = @root, queue = [root], order = [])
    queue << root.left unless root.left.nil?
    queue << root.right unless root.right.nil?
    order << queue.shift.data
    return puts order if queue.empty?

    recursive_level_order(queue[0], queue, order)
  end

  def inorder(root = @root, &block)
    order = []
    return if root.nil?

    inorder(root.left, &block)
    yield(root.data) if block_given?
    order << root.data
    puts order unless block_given?
    inorder(root.right, &block)
  end

  def preorder(root = @root, &block)
    order = []
    return if root.nil?

    yield(root.data) if block_given?
    order << root.data
    puts order unless block_given?
    preorder(root.left, &block)
    preorder(root.right, &block)
  end

  def postorder(root = @root, &block)
    order = []
    return if root.nil?

    postorder(root.left, &block)
    postorder(root.right, &block)
    yield(root.data) if block_given?
    order << root.data
    puts order unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

t = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
t.insert(10000)
t.pretty_print
t.recursive_level_order