#!/usr/bin/env ruby
require_relative 'lib/shape/shape'
require_relative 'lib/shape/rectangle'
require_relative 'impact_tree'

size = Rectangle.new(2,4,5,10)
mytree = Impact_tree.new(0,size)
puts 'test'
