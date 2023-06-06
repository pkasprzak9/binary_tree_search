# frozen_string_literal: false

class Node
  attr_accessor :left, :right, :data

  def <=>(other)
    @data <=> other.data
  end

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
