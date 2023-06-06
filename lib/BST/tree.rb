# frozen_string_literal: false

require_relative './node'

class Tree
  attr_reader :root

  def initialize(nums)
    @root = nil
    @nums = nums
  end

  def build_tree
    @root = Node.new(@nums.first)
    @nums.each_with_index do |num, index|
      next if index.zero?

      @root.insert_value(num)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
