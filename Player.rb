require_relative 'Character'

class Player < Character
  def initialize(image, speed=4, speed_mod=2, x_pos=100, y_pos=100, angle=0) 
    super(image, speed, speed_mod, x_pos, y_pos, angle)
  end

  # Change name if needed 
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
