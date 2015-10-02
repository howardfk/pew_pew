class Wall
  attr_accessor :x,:y,:x_leng,:y_leng
  def initialize(x,y, x_leng=40, y_leng=10)
    # Default Positioning
    self.x=x
    self.y=y
    self.x_leng=x_leng
    self.y_leng=y_leng
  end

  def draw
    Gosu::draw_rect(x,y,x_leng,y_leng,Gosu::Color.argb(0xff_00ff00))
  end
end
