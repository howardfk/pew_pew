
require_relative 'Shape'

class Circle < Shape
  attr_accessor :radius
  def initialize(x, y, radius)
    super(x, y)
    @radius = radius
  end
end
