
require_relative 'Shape'

class Polygon < Shape
  attr_reader :side_count

  def initialize(x,y,side_count)
    super(x,y)
    @side_count = side_count 
  end
end
