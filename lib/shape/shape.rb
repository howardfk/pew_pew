##!/usr/bin/env ruby

# Shape class is inteded to be use for bounds in 2D space
# This class is specificly used in 2D game pewpew for collition detection
class Shape
  attr_accessor :x, :y

  # x, y coordinates will be in the middle of: Circals, Squres and Rectangles.  
  # left bound = x - width/2
  # right bound = x + width/2
  # top bound = y - width/2
  # bottom bound = y + width/2

  def initialize(x=5,y=5)
    @x = x
    @y = y
  end
end
