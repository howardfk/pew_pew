#!/usr/bin/env ruby

require_relative 'Rectangle'

class Square < Rectangle
  def initialize(x, y, side)
    super(x, y, side, side)
  end
end
