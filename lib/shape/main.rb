#!/usr/bin/env ruby

require_relative 'Rectangle'
require_relative 'Square'

rec1 = Rectangle.new(1,4,20,25)
sqr1 = Square.new(10,15,20)

puts "Rectangle one \n "

puts "Num sides #{rec1.side_count}"
puts "perimiter #{rec1.perimeter}"
puts "Area #{rec1.area}"

puts "how many shapes?"
puts "\nSqure one \n "

puts "num sides #{sqr1.side_count}"
puts "Perimiter: #{sqr1.perimeter}"
puts "Area: #{sqr1.area}"

puts 'test num_of_shapes as attr_accessor'

puts rec1.inspect
puts sqr1.inspect
