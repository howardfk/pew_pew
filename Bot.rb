require_relative 'Character'

class Bot < Character
  def initialize(image, speed=4, speed_mod=2, x_pos=500, y_pos=500, angle=0) 
    super(image, speed, speed_mod, x_pos, y_pos, angle)
  end

  def update
    #will nee to ad some kind of AI but for now bot will do nothing
  end

end
