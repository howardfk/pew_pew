#!/usr/bin/env ruby

require_relative 'Polygon'

class Rectangle < Polygon
  attr_reader :perimeter, :area, :upper, :lower, :left, :right
  attr_accessor :hight, :width

  def initialize(x, y, hight, width)
    super(x, y, 4)
    @hight = hight
    @width = width
    @area  = hight*width
    @perimeter = 2*hight*width
    @upper = y - hight/2
    @lower = y + hight/2
    @left  = x - width/2 
    @right = x + width/2
  end

  def reshape(color, length,width) 
    self.length = length
    self.width = width
  end

end
