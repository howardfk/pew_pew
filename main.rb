#!/usr/bin/env ruby

require 'gosu'

require_relative 'Bot'
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
    @bot = Bot.new(Gosu::Image.new(self, "assets/player.png", false))
    #@wall = Wall.new(10,50)
  end

  def update
    # Player info that is upated, movment requires the mouse_y from Gosu::window
    @player.update(self.mouse_x, self.mouse_y)
    @bot.update
  end

  def draw
    @player.draw
    @bot.draw
    test = draw_quad(20,20, Gosu::Color.rgba(100,100,245,0.5),9,295, Gosu::Color.rgb(200,200,200), 100, 25, Gosu::Color.argb(0xff_00ffff), 200, 205, Gosu::Color.argb(0xff_00ffff), 2)
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
