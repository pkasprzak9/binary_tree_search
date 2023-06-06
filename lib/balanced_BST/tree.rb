# frozen_string_literal: false

require_relative './node'

class Tree
  attr_reader :root

  # Initializes a new instance of the Tree class with the given array, sorting
  # and removing duplicates, and then building the binary tree.
  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  # Recursively builds a binary search tree from a sorted array of values.
  def build_tree(array, start_index = 0, end_index = array.size - 1)
    return nil if start_index > end_index

    mid = (start_index + end_index) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array, start_index, mid - 1)
    node.right = build_tree(array, mid + 1, end_index)

    node
  end

  # Inserts a new value into the binary search tree.
  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # Deletes a node with the specified value from the binary search tree.
  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      left_most = left_most(node.right)
      node.data = left_most.data
      node.right = delete(left_most.data, node.right)
    end
    node
  end

  # Finds a node with the specified value in the binary search tree.
  def find(value, node = @root)
    return nil if node.nil?

    return node if node.data == value

    left_result = find(value, node.left)
    return left_result unless left_result.nil?

    right_result = find(value, node.right)
    return right_result unless right_result.nil?

    nil
  end

  # Performs a level-order traversal of the binary search tree and returns an
  # array of node values.
  def level_order
    return nil if @root.nil?

    results = []
    queue = [@root]

    until queue.empty?
      node = queue.shift
      data = node.data

      if block_given?
        yield node
      else
        results << data
      end

      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    results unless block_given?
  end

  # Performs an inorder traversal of the binary search tree and returns an
  # array of node values.
  def inorder(node = @root, arr = [], &block)
    return nil if node.nil?

    inorder(node.left, arr, &block)
    if block_given?
      yield node
    else
      arr << node.data
    end
    inorder(node.right, arr, &block)
    arr
  end

  # Performs a preorder traversal of the binary search tree and returns an
  # array of node values.
  def preorder(node = @root, arr = [], &block)
    return nil if node.nil?

    if block_given?
      yield node
    else
      arr << node.data
    end
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)
    arr
  end

  # Performs a postorder traversal of the binary search tree and returns an
  # array of node values.
  def postorder(node = @root, arr = [], &block)
    return nil if node.nil?

    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    if block_given?
      yield node
    else
      arr << node.data
    end
    arr
  end

  # Calculates the height of a given node in the binary search tree.
  # The height is defined as the number of edges in the longest path from the
  # given node to a leaf node.
  def height(node = @root, result = 0)
    return result if node.nil?

    result += 1
    height(node.left, result)
    height(node.right, result)
  end

  # Calculates the depth of a given node in the binary search tree relative to
  # the root. The depth is defined as the number of edges from the root to the
  # given node.
  def depth(node, root = @root, result = 0)
    return nil if root.nil?

    return result if root == node

    left_result = depth(node, root.left, result + 1)
    return left_result unless left_result.nil?

    right_result = depth(node, root.right, result + 1)
    return right_result unless right_result.nil?

    nil
  end

  # Checks if the binary search tree is balanced, i.e., the heights of its left
  # and right subtrees differ by at most 1.
  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return balanced?(node.left) && balanced?(node.right) if (left_height - right_height).abs <= 1

    false
  end

  # Rebalances the binary search tree by creating a new tree with the elements
  # in sorted order.
  def rebalance
    arr = inorder
    @root = build_tree(arr)
  end

  # Prints a visual representation of the binary search tree.
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  # Finds the leftmost (minimum) node in a subtree.
  def left_most(node)
    node = node.left until node.left.nil?

    node
  end
end
