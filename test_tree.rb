#!/usr/bin/env ruby
require_relative 'lib/shape/rectangle'
require_relative 'lib/shape/shape'
require_relative 'impact_tree'
require 'gosu'
 
#Setting up global varibles for testing
$height = 400
$width= 600

$masterlist = Array.new
for i in 1..20
  x = rand(24...$width-24) 
  y = rand(12..$height-12)
  temp = Rectangle.new(x, y, 12, 6)
  $masterlist << temp
end  

 
$screen_box = Rectangle.new($width/2,$height/2, $width, $height)

class GameWindow < Gosu::Window
  SCREEN_HEIGHT = $height
  SCREEN_WIDTH = $width 

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "DEBUG THE TREE!"
    @txt = Gosu::Font.new(self,"Georgia",16)
  end

  def update
  end

  def draw
    #mycolor = Gosu::Color.rgba(100,100,245,0.5)
    teal = Gosu::Color.argb(0xff_00ffff)
    green = Gosu::Color.argb(0xff_00ff00)
    red = Gosu::Color.argb(0xff_ff0000)

    # add text here to the thing
    $masterlist.each{|thing| makeShape(thing, teal)
    @txt.draw("#{thing.x}, #{thing.y}", thing.x, thing.y, 4)}
    

    myTree = ImpactTree.new($screen_box,0)
    myTree.unload

    $masterlist.each{|thing| myTree.insert(thing)}

    makeShape($masterlist[0], red)

    near = myTree.retrive($masterlist[0])
    #puts near.length
    puts myTree.inspect
    near.each{|thing| makeShape(thing,green)}
    makeShape($masterlist[0], red)
  end

  def makeShape(rect, color)
    draw_quad(rect.left, rect.upper, color, rect.right, rect.upper, color, rect.right, rect.lower, color, rect.left, rect.lower, color)
  end
end

window = GameWindow.new
window.show
