#require_relative 'shape/rectangle'
# ImpactTree is a quadtree. Determins objects that are likely to collide in a 2-D spcae.
# ImpactTree beavor is manipulated with class varbles. Allows for control over depth of tree.
#   @@max_level and @@max_data allow ballance of memory useage vs performance
# data_list are all the objects your intersted in tracking stored in a node

class ImpactTree
  @@max_data = 1000
  @@max_level = 20000
  attr_accessor :level, :node_bounds, :nodes, :data_list
  # node_bounds is a Shape that has positoin, and dimentions.
  # More info in the shape class

  def initialize(node_bounds, level)
    @level  = level
    @node_bounds = node_bounds
    @data_list  = Array.new
    @nodes = Array.new
  end

  def unload
    self.data_list.clear
    self.nodes.each{|node| node.unload}
  end

  # Splits a node into children subnodes with new sub-bounds.
  # Assume all bounds are retangles in this model 
  def branch
    sub_hight= self.node_bounds.width/2
    sub_width = self.node_bounds.hight/2
    x = self.node_bounds.x
    y = self.node_bounds.y

    self.nodes = Array.new
    nodes << ImpactTree.new(self.level += 1, Rectangle.new(x + sub_width, y + sub_hight, sub_width, sub_hight))
    nodes << ImpactTree.new(self.level += 1, Rectangle.new(x - sub_width, y + sub_hight, sub_width, sub_hight))
    nodes << ImpactTree.new(self.level += 1, Rectangle.new(x - sub_width, y - sub_hight, sub_width, sub_hight))
    nodes << ImpactTree.new(self.level += 1, Rectangle.new(x + sub_width, y - sub_hight, sub_width, sub_hight))
  end

  # obj_bounds is a Shape class object
  # getQaud retuns index 1..4 represent each subquad
  def getQuad(obj_bounds)
    index = -1
    
    #Boolen values indicate if item is complety contained in half boundrys
    #remeber self.nodes[0].lower == self.nodes[3].upper
    top_half    = (obj_bounds.upper > self.nodes[0].upper) && (obj_bounds.lower < self.nodes[0].lower) ? true : false
    bottom_half = (obj_bounds.upper > self.nodes[0].lower) && (obj_bounds.lower < self.nodes[4].lower) ? true : false
    left_half   = (obj_bounds.left  > self.nodes[1].left ) && (obj_bounds.right < self.nodes[1].right) ? true : false
    right_half  = (obj_bounds.right < self.nodes[0].right) && (obj_bounds.left  > self.nodes[1].left ) ? true : false

    index = top_half    && right_half ? 0 : index
    index = top_half    && left_half  ? 1 : index
    index = bottom_half && left_half  ? 2 : index
    index = top_half    && right_half ? 3 : index

    # Need to consider outlyer case if object moves past the edge of map where:
    #   obj_bounds.upper && obj_bounds.lower < 0
    # This probably will need to be addressed in the managment class
  end

  # Incerting shapes for collition detection must be from the shape class
  def insert(obj_bounds)
    self.nodes[0] != nil ? 
      (index = getQuad(obj_bounds) 
       index != -1 ? nodes[index].insert(obj_bounds) : nil) : nil

    self.data_list << obj_bounds

    (data_list.length > @@max_data) && (level < @@max_level) ? 
       (nodes[0] == nil ? branch : self.data_list.each{|obj_bounds| index = getQuad(obj_bounds)
                                                  index != -1 ? nodes[index] << obj_bounds : nil}) : nil
  end

  # I feel like there is a faster way to do the retrive by 
  #   noting the position of each object in the tree.... 
  def retrive(obj_bounds, return_data = Array.new)
    index = getQuad(obj_bounds)
    (index != -1) && (self.nodes[0] != nil) ? retrive(obj_bounds, return_data) : nil
    self.data_list.each{|obj_bounds| return_data << obj_bounds}
  end

end
