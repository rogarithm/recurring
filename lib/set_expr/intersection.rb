require_relative './collection'

class Intersection < Collection
  attr_reader :elems

  def initialize
    @elems = []
  end

  def add_elem elem
    @elems << elem
  end

  def includes date
    @elems.each do |tmpr_expr|
      return false if !tmpr_expr.includes(date)
    end
    true
  end
end
