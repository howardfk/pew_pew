#!/usr/bin/env ruby

require_relative 'Polygon'

class Rectangle < Polygon
  attr_reader :perimeter, :area, :upper, :lower, :left, :right
  attr_accessor :height, :width

  def initialize(x, y, width, height)
    super(x, y, 4)
    @height = height
    @width = width
    @area  = height*width
    @perimeter = 2*height*width
    @upper = y - height/2
    @lower = y + height/2
    @left  = x - width/2 
    @right = x + width/2
  end

  def reshape(color, length,width) 
    self.length = length
    self.width = width
  end

end
