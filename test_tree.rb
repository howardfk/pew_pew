#!/usr/bin/env ruby
require_relative 'lib/shape/rectangle'
require_relative 'lib/shape/shape'
require_relative 'impact_tree'
require 'gosu'
 
#Setting up global varibles for testing
$height = 400
$width= 600

$masterlist = Array.new
for i in 1..200
  x = rand(6...$width) 
  y = rand(12..$height)
  temp = Rectangle.new(x, y, 12, 6)
  $masterlist << temp
end  

 
$screen_box = Rectangle.new($width/2,$height/2, $height, $width)

class GameWindow < Gosu::Window
  SCREEN_HEIGHT = $height
  SCREEN_WIDTH = $width 

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "DEBUG THE TREE!"
  end

  def update
  end

  def draw
    #test = draw_quad(20,20, Gosu::Color.rgba(100,100,245,0.5),9,295, Gosu::Color.rgb(200,200,200), 100, 25, Gosu::Color.argb(0xff_00ffff), 200, 205, Gosu::Color.argb(0xff_00ffff), 2)
    
    #mycolor = Gosu::Color.rgba(100,100,245,0.5)
    mycolor = Gosu::Color.argb(0xff_00ffff)
    $masterlist.each{|thing| makeShape(thing, mycolor)}

    myTree = ImpactTree.new($screen_box,0)
    myTree.unload
    for i in 0...$masterlist.length
      myTree.insert($masterlist[i])
    end

    color_red = Gosu::Color.argb(0xff_ff0000)
    makeShape($masterlist[0], color_red)
    puts myTree.retrive($masterlist[0]).length
  end

  def makeShape(rect, color)
    draw_quad(rect.left, rect.upper, color, rect.right, rect.upper, color, rect.right, rect.lower, color, rect.left, rect.lower, color)
  end
end

window = GameWindow.new
window.show


#masterlist.each{|stuff| myTree.insert(stuff)}


#myTree.retrive(masterlist[0])

