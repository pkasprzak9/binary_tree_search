# frozen_string_literal: false

class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end

  def insert_value(value)
    if value < self.value
      if @left.nil?
        @left = Node.new(value)
      else
        @left.insert_value(value)
      end
    else
      if @right.nil?
        @right = Node.new(value)
      else
        @right.insert_value(value)
      end
    end
  end
end
