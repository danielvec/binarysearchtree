# node class with attributes for data, left and right children
class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# tree class which accepts an array and creates a binary search tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  # method which takes an array of data and turns it into a balanced binary tree full of Node objects
  def build_tree(array)
    array = array.sort.uniq
    return if array.empty?

    root = Node.new(array[array.length/2])
    root.left = build_tree(array[0...array.length/2])
    root.right = build_tree(array[array.length/2+1...array.length])

    root
  end

  # method which accepts a value to insert into the binary tree
  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    if root.data > value
      root.left = insert(value, root.left)
    elsif root.data < value
      root.right = insert(value, root.right)
    end

    root
  end

  # method which accepts a value to delete from the binary tree
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

  # method to find a node of a given value in the tree
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

  # method which traverses the tree in breadth-first level order and yields each node to the provided block
  def level_order(root = @root)
    queue = [root]
    order = []
    until queue.empty?
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?
      yield(queue.shift.data) if block_given?
      order << queue.shift.data unless block_given?
    end
    order unless block_given?
  end

  # recursive implementation of level_order method
  def recursive_level_order(root = @root, queue = [root], order = [])
    queue << root.left unless root.left.nil?
    queue << root.right unless root.right.nil?
    order << queue.shift.data
    return puts order if queue.empty?

    recursive_level_order(queue[0], queue, order)
  end

  # method which traverses the tree inorder and yields each node to the provided block
  def inorder(root = @root, &block)
    order = []
    return if root.nil?

    root.left.nil? && root.right.nil?
    order << inorder(root.left, &block)
    yield(root.data) if block_given?
    order << root.data
    order << inorder(root.right, &block)
    order.flatten.compact unless block_given?
  end

  # method which traverses the tree preorder and yields each node to the provided block
  def preorder(root = @root, &block)
    order = []
    return if root.nil?

    yield(root.data) if block_given?
    order << root.data
    order << preorder(root.left, &block)
    order << preorder(root.right, &block)
    order.flatten.compact unless block_given?
  end

  # method which traverses the tree postorder and yields each node to the provided block
  def postorder(root = @root, &block)
    order = []
    return if root.nil?

    order << postorder(root.left, &block)
    order << postorder(root.right, &block)
    yield(root.data) if block_given?
    order << root.data
    order.flatten.compact unless block_given?
  end

  # method to determine height of a node
  def height(root = @root)
    return -1 if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)
    [left_height, right_height].max + 1
  end

  # method to determine depth of a node
  def depth(root = @root)
    height - height(root)
  end

  # method to determine if tree is balanced
  def balanced?
    root = @root
    left_height = height(root.left)
    right_height = height(root.right)
    maximum = [left_height, right_height].max
    minimum = [left_height, right_height].min
    maximum - minimum < 2
  end

  # method to rebalance a tree
  def rebalance
    @root = build_tree(level_order)
  end

  # method to display the tree as a tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

# Create a binary search tree from an array of random numbers 
test_tree = Tree.new(Array.new(15) { rand(1..100) })
test_tree.pretty_print
# Confirm that the tree is balanced by calling #balanced?
p test_tree.balanced?
# Print out all elements in level, pre, post, and in order
p test_tree.level_order
p test_tree.preorder
p test_tree.postorder
p test_tree.inorder
# Unbalance the tree by adding several numbers > 100
test_tree.insert(101)
test_tree.insert(102)
test_tree.insert(103)
# Confirm that the tree is unbalanced by calling #balanced?
p test_tree.balanced?
# Balance the tree by calling #rebalance
test_tree.rebalance
# Confirm that the tree is balanced by calling #balanced?
p test_tree.balanced?
# Print out all elements in level, pre, post, and in order
p test_tree.level_order
p test_tree.preorder
p test_tree.postorder
p test_tree.inorder