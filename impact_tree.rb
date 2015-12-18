#require_relative 'shape/shape'
# Impact Tree is a quadtree. It determins objects that are likely to collide in a 2-D spcae.
# ImpactTree beavor is manipulated with class varbles. Allows for control over depth of tree.

class ImpactTree
  @@max_data = 1
  @@max_level = 20
  # Bounds is a Shape that has positoin, and dimentions.
  # More info in the shape class
  def initiatize(level=0, node_bounds)
    attr_accessor :level, :node_bounds
    @level  = level
    @node_bounds = node_bounds
    @data_list  = array.new
    @nodes = Array.new
  end

  def clear
    @data_list.clear
    self.nodes.each{|node| node.clear}
  end

  # Splits a node into children subnodes with new sub-bounds.
  # All bounds are retangles in this model 
  def branch
    sub_high  = self.node_bounds.width/2
    sub_width = self.node_bounds.hight/2
    x = self.node_bounds.x
    y = self.node_bounds.y
    
    self.nodes = Array.new
    nodes << ImpactTree(self.level += 1, Shape.new(x + sub_width, y - sub_width, sub_width, sub_hight))
    nodes << ImpactTree(self.level += 1, Shape.new(x - sub_width, y - sub_width, sub_width, sub_hight))
    nodes << ImpactTree(self.level += 1, Shape.new(x - sub_width, y + sub_width, sub_width, sub_hight))
    nodes << ImpactTree(self.level += 1, Shape.new(x + sub_width, y + sub_width, sub_width, sub_hight))
  end

  # obj_bounds is a Shape class object
  # getQaud retuns index 1..4 represent each subquad
  def getQuad(obj_bounds)
    index = -1
    x_mid = obj_bounds.x
    y_mid = obj_bounds.y
    left_b  = x_mid - obj_bounds.width/2
    right_b = x_mid + obj_bounds.width/2
    upper_b = y_mid - obj_bounds.hight/2 
    upper_b = obj_bounds.upper
    lower_b = y_mid + obj_bounds.hight/2 

    #Boolen values indicate if item is complety contained in half boundrys
    top_half = (obj_bounds.upper > self.nodes[0].node_bounds.upper) && (obj_bounds.lower < self.nodes[0].node_bounds.lower) ? true : false
    #bottom_half = (obj_bounds.lower > self.node_bounds.upper) && (obj_bounds.upper > self.node_bounds.upper) ? true : false
    #left_half   = (obj_bounds.lower > self.node_bounds.upper) && (obj_bounds.upper > self.node_bounds.upper) ? true : false
    #right_half  = (obj_bounds.lower > self.node_bounds.upper) && (obj_bounds.upper > self.node_bounds.upper) ? true : false
  end

  def insert()
  end
end
