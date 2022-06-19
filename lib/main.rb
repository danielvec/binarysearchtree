require_relative 'tree'

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