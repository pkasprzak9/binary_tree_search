# frozen_string_literal: false

require_relative './tree'

arr = []
10.times { arr << rand(40) }
tree = Tree.new(arr)
tree.build_tree
puts tree.pretty_print
