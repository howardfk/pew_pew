class Character
  attr_accessor :angle, :x_pos, :y_pos, :speed, :speed_mod, :is_running

  def initialize(image, speed=4, speed_mod=1, x_pos=100, y_pos=100, angle=0) 
    @image = image;
    if !image
      @image=Gosu::Image.new("assets/player.png")
    else
      @image=image
    end

    self.x_pos = x_pos
    self.y_pos = y_pos
    self.angle = angle

    self.player_speed = speed*speed_mod
    self.is_running = false

    #this varbule might not be needed 
    @speed_mod = speed_mod
  end

  #was pint_to
  def face_to(look_x, look_y)
    self.angle = Gosu::angle(self.x_pos, self.y_pos, look_x, look_y)
  end

  def movement_angle x_down, y_down
    Gosu::angle(0,0,x_down,y_down)
  end

  def move x_speed, y_speed
    # Zero values do not move
    if x_speed!=0 or y_speed!=0
      x_speed = x_speed!=0 ? (x_speed>0 ? 1 : -1) : 0
      y_speed = y_speed!=0 ? (y_speed>0 ? 1 : -1) : 0

    # Movment Angles 0:pi/4:2pi
    movement_angle = self.movment_angle(x_speed,y_speed)

    # Distatnce to move
    # previous code used if,then to determ if running
    # this code will assign speed=speed*mod_speed, if running mod_speed!=1 else pick mod_speed
    #movement_diff renamed ot move_diff
    move_diff = self.player_speed
    # Do we need to update mod_speed befor we calculate the move_diff?

    self.x_pos += Gosu::offset_x(movement_angle, move_diff)
    self.y_pos += Gosu::offset_y(movement_angle, move_diff)
    end
  end

  def draw
    @image.draw(self.x, self.y, 1, self.angle)
  end

end
