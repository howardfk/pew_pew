class Character
  attr_accessor :angle, :x_pos, :y_pos, :speed, :speed_mod, :is_running, :player_speed

  def initialize(image, speed=4, speed_mod=2, x_pos=100, y_pos=100, angle=0) 
    @image = image;
    if !image
      @image=Gosu::Image.new("assets/player.png")
    else
      @image=image
    end

    self.x_pos = x_pos
    self.y_pos = y_pos
    self.angle = angle

    self.player_speed = speed
    self.is_running = false

    #this varbule might not be needed 
    @speed_mod = speed_mod
  end

  #was point_to
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
    movement_angle = self.movement_angle(x_speed,y_speed)

    # Distatnce to move
    # previous code used if,then to determ if running
    # this code will assign speed=speed*mod_speed, if running mod_speed!=1 else pick mod_speed
    #movement_diff renamed ot move_diff
     
    move_diff = is_running ? self.player_speed * self.speed_mod : self.player_speed
    # Do we need to update mod_speed befor we calculate the move_diff?

    self.x_pos += Gosu::offset_x(movement_angle, move_diff)
    self.y_pos += Gosu::offset_y(movement_angle, move_diff)
    end
  end

  def draw
    @image.draw_rot(self.x_pos, self.y_pos, 1, self.angle, 0.5, 0.7)
  end

  # Chnge name if needed 
  # Passe values to the managment class to update on window
  def update(mouse_x, mouse_y)
    w_down = Gosu::button_down? Gosu::KbW
    a_down = Gosu::button_down? Gosu::KbA
    s_down = Gosu::button_down? Gosu::KbS
    d_down = Gosu::button_down? Gosu::KbD
    left_shift_down = Gosu::button_down? Gosu::KbLeftShift

    x_vel=0
    y_vel=0

    if w_down && s_down
    elsif w_down
      y_vel=-1
    elsif s_down
      y_vel=1
    end

    if a_down && d_down
    elsif a_down
      x_vel=-1
    elsif d_down
      x_vel=1
    end

    if left_shift_down
      self.is_running = true
    else
      self.is_running = false
    end

    self.move(x_vel, y_vel)

    # Update direction of player after setting player's x,y 
    self.face_to(mouse_x, mouse_y)     
  end

end
