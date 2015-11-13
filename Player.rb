require_relative 'Character'

class Player < Character
  def initialize(image, speed=4, speed_mod=2, x_pos=100, y_pos=100, angle=0) 
    super(image, speed, speed_mod, x_pos, y_pos, angle)
  end
end
