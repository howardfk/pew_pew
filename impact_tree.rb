#require_relative 'shape/rectangle'
# ImpactTree is a quadtree. Determins objects that are likely to collide in a 2-D spcae.
# ImpactTree beavor is manipulated with class varbles. Allows for control over depth of tree.
#   @@max_level and @@max_data allow ballance of memory useage vs performance
# data_list are all the objects your intersted in tracking stored in a node

class ImpactTree
  @@max_data = 5
  @@max_level = 1
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
    sub_width = self.node_bounds.width/2.0
    sub_hight = self.node_bounds.hight/2.0
    x = self.node_bounds.x
    y = self.node_bounds.y

    self.nodes = Array.new
    level = self.level + 1
    # Need to consider the rounding errors and if we planon doing hole numbers
    self.nodes << ImpactTree.new(Rectangle.new(x + sub_width/2, y - sub_hight/2, sub_width, sub_hight), level)
    self.nodes << ImpactTree.new(Rectangle.new(x - sub_width/2, y - sub_hight/2, sub_width, sub_hight), level)
    self.nodes << ImpactTree.new(Rectangle.new(x - sub_width/2, y + sub_hight/2, sub_width, sub_hight), level)
    self.nodes << ImpactTree.new(Rectangle.new(x + sub_width/2, y + sub_hight/2, sub_width, sub_hight), level)
  end

  # obj_bounds is a Shape class object
  # getQuad retuns index 0..3 represent each subquad of self
  def getQuad(obj_bounds)
    index = -1
    #Boolen values indicate if item is complety contained in half boundrys
    #remeber self.nodes[0].lower == self.nodes[3].upper
    top_half    = ((obj_bounds.upper > self.nodes[0].node_bounds.upper) && (obj_bounds.lower < self.nodes[0].node_bounds.lower)) ? true : false
    top_half    = ((obj_bounds.upper > self.nodes[0].node_bounds.upper) && (obj_bounds.lower < self.nodes[0].node_bounds.lower)) ? true : false
    bottom_half = ((obj_bounds.upper > self.nodes[0].node_bounds.lower) && (obj_bounds.lower < self.nodes[3].node_bounds.lower)) ? true : false
    left_half   = ((obj_bounds.left  > self.nodes[1].node_bounds.left ) && (obj_bounds.right < self.nodes[1].node_bounds.right)) ? true : false
    right_half  = ((obj_bounds.right < self.nodes[0].node_bounds.right) && (obj_bounds.left  > self.nodes[1].node_bounds.left )) ? true : false

    index = (top_half    && right_half) ? 0 : index
    index = (top_half    && left_half ) ? 1 : index
    index = (bottom_half && left_half ) ? 2 : index
    index = (top_half    && right_half) ? 3 : index

    # Need to consider outlyer case if object moves past the edge of map where:
    #   obj_bounds.upper && obj_bounds.lower < 0
    # This probably will need to be addressed in the managment class
  end

  # obj_bounds passed for collition detection must be from the shape class
  def insert(obj_bounds)
    if self.nodes.empty? == false
      index = self.getQuad(obj_bounds)
      if index != -1
        self.nodes[index].insert(obj_bounds)
      end
    end

    self.data_list << obj_bounds

    if ((self.data_list.length > @@max_data) && (level < @@max_level))
      if self.nodes.empty? == true
        self.branch
      end 

      self.data_list.each{|thing| 
        index = self.getQuad(thing)
        if index != -1
          self.nodes[index].data_list << thing
          self.data_list.delete(thing)
        end}
    end
  end

  # I feel like there is a faster way to do the retrieve by 
  #   noting the position of each object in the tree.... 
  def retrieve(obj_bounds, return_data = Array.new)
    index = self.getQuad(obj_bounds)
    if (index != -1) && (self.nodes[0] != nil)
      self.nodes[index].retrieve(obj_bounds, return_data)
    end
    self.data_list.each{|obj_bounds| return_data << obj_bounds}
  end

  def get_node_bounds(return_bounds = Array.new)
    if self.nodes[0] != nil
      self.nodes[0].get_node_bounds(return_bounds)
      self.nodes[1].get_node_bounds(return_bounds)
      self.nodes[2].get_node_bounds(return_bounds)
      self.nodes[3].get_node_bounds(return_bounds)
    end
    return_bounds << self.node_bounds 
  end
end