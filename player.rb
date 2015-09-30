class Player
  attr_accessor :angle, :x, :y, :player_speed, :run_multiplier, :is_running

  def initialize(image, player_speed=4, run_multiplier=2, x=400, y=300, angle=0)
    @image = image

    # Default Position and Angle
    self.x=x
    self.y=y
    self.angle=angle

    # Running speed per update
    self.player_speed=player_speed

    # Always false on init
    self.is_running = false

    # Multiplied times speed when run mode active
    @run_multiplier=run_multiplier
    if !image
      @image=Gosu::Image.new("assets/player.png")
    else
      @image=image
    end
  end

  def point_to look_x, look_y
    self.angle = Gosu::angle(self.x, self.y, look_x, look_y)
  end

  def movement_angle x_down, y_down
    Gosu::angle(0, 0, x_down, y_down)
  end

  def move x_vel, y_vel 
    # only move if non-zero values passed
    if x_vel!=0 or y_vel!=0
      # set x_vel/y_vel to 1 if positive, -1 if negative, 0 otherwise
      x_vel = x_vel!=0 ? (x_vel>0 ? 1 : -1) : 0
      y_vel = y_vel!=0 ? (y_vel>0 ? 1: -1) : 0
      
      # 0, 45, 90, etc
      movement_angle = self.movement_angle(x_vel, y_vel)

      # Move this number of steps
      if self.is_running then movement_diff = self.player_speed * self.run_multiplier
      else movement_diff = self.player_speed end

      # use offset to calculate how much to move in x/y directions
      self.x += Gosu::offset_x(movement_angle, movement_diff)
      self.y += Gosu::offset_y(movement_angle, movement_diff)
    end
  end

  def draw
    @image.draw_rot(self.x, self.y, 1, self.angle)
  end
  
end
