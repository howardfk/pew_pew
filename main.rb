#!/usr/bin/env ruby

require 'gosu'

require_relative 'Player'
#require_relative 'wall'

class GameWindow < Gosu::Window

  SCREEN_HEIGHT=800
  SCREEN_WIDTH=900

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "Welcome to Battle Arena!"

    # Must pass in image when creating player
    @player = Player.new(Gosu::Image.new(self, "assets/player.png", false))
    #@wall = Wall.new(10,50)
  end

  def update
    # Player info that is upated, movment requires the mouse_y from Gosu::window
    @player.update(self.mouse_x, self.mouse_y)
    # Fallowing 34 lines moved to Charicter#Update
    #w_down = Gosu::button_down? Gosu::KbW
    #a_down = Gosu::button_down? Gosu::KbA
    #s_down = Gosu::button_down? Gosu::KbS
    #d_down = Gosu::button_down? Gosu::KbD
    #left_shift_down = Gosu::button_down? Gosu::KbLeftShift

    #x_vel=0
    #y_vel=0

    #if w_down && s_down
    #elsif w_down
      #y_vel=-1
    #elsif s_down
      #y_vel=1
    #end

    #if a_down && d_down
    #elsif a_down
      #x_vel=-1
    #elsif d_down
      #x_vel=1
    #end

    #if left_shift_down
      #@player.is_running=true
    #else
      #@player.is_running=false
    #end

    #@player.move(x_vel, y_vel)

    ## Update direction of player after setting player's x,y 
    #@player.point_to(self.mouse_x, self.mouse_y)     
  end

  def draw
    @player.draw
    #@wall.draw
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if Gosu::button_down? Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
