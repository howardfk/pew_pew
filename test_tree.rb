#!/usr/bin/env ruby
require_relative 'lib/shape/rectangle'
require_relative 'lib/shape/shape'
require_relative 'impact_tree'
require 'gosu'

screensize = Rectangle.new(25,25,50,50)

myTree = ImpactTree.new(screensize,0)
# Making a list of random objects insize a 50x50 box
# all objets will be, 2x4 rectangles with random positions

masterlist = Array.new
for i in 1..90
  puts "the #{i}th loop"
  x = rand(2..48) 
  y = rand(4..46)
  temp = Rectangle.new(x, y, 4, 2)
  masterlist << temp
  puts temp.inspect
end


#masterlist.each{|thing| puts thing.upper 
  #thing.lower}
#puts 'MASTER LIST THING'
#puts masterlist[masterlist.length-1].inspect

myTree.unload
#for i in 0..masterlist.length
  #puts masterlist[i]
  #myTree.insert(masterlist[i])
#end

masterlist.each{|stuff| puts stuff.inspect 
  myTree.insert(stuff)}
puts 'INSPECT'
puts masterlist[0].inspect
puts masterlist[0].upper
myTree.retrive(masterlist[0])
