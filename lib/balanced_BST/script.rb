# frozen_string_literal: false

require_relative './tree'

arr = (Array.new(15) { rand(1..100) })

puts 'Creating a new tree...'
sleep(5)
tree = Tree.new(arr)
tree.pretty_print
sleep(1)
puts "Is the tree balanced: #{tree.balanced?}"

sleep(1)
puts 'Level Order:'
p tree.level_order

sleep(1)
puts 'Preorder:'
p tree.preorder

sleep(1)
puts 'Inorder:'
p tree.inorder

sleep(1)
puts 'Postorder:'
p tree.postorder

15.times do
  x = rand(100..200)
  tree.insert(x)
end
sleep(1)
puts 'Inserting new nodes...'
sleep(5)
tree.pretty_print
sleep(1)
puts "Is the tree balanced: #{tree.balanced?}"
sleep(1)
puts 'Rebalancing...'
sleep(5)
tree.rebalance
tree.pretty_print
sleep(1)
puts "Is the tree balanced: #{tree.balanced?}"

sleep(1)
puts 'Level Order:'
p tree.level_order

sleep(1)
puts 'Preorder:'
p tree.preorder

sleep(1)
puts 'Inorder:'
p tree.inorder

sleep(1)
puts 'Postorder:'
p tree.postorder
