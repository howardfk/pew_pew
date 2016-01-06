#require_relative 'shape/rectangle'
# ImpactTree is a quadtree. Determins objects that are likely to collide in a 2-D spcae.
# ImpactTree beavor is manipulated with class varbles. Allows for control over depth of tree.
#   @@max_level and @@max_data allow ballance of memory useage vs performance
# data_list are all the objects your intersted in tracking stored in a node

class ImpactTree
  @@max_data = 4
  @@max_level = 4
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
    sub_height = self.node_bounds.height/2.0
    x = self.node_bounds.x
    y = self.node_bounds.y

    level = self.level + 1
    # Need to consider the rounding errors and if we plan on doing hole numbers
    self.nodes << ImpactTree.new(Rectangle.new(x + sub_width/2, y - sub_height/2, sub_width, sub_height), level)
    self.nodes << ImpactTree.new(Rectangle.new(x - sub_width/2, y - sub_height/2, sub_width, sub_height), level)
    self.nodes << ImpactTree.new(Rectangle.new(x - sub_width/2, y + sub_height/2, sub_width, sub_height), level)
    self.nodes << ImpactTree.new(Rectangle.new(x + sub_width/2, y + sub_height/2, sub_width, sub_height), level)
  end

  # obj_bounds is a Shape class object
  # getQuad retuns index 0..3 represent each subquad of self
  # re write get quad to return "node tree structure" and use bounds and data to do waht we need
  def getQuad(obj_bounds)
    index = -1
    top_half = ((obj_bounds.upper > self.nodes[0].node_bounds.upper) && (obj_bounds.lower < self.nodes[0].node_bounds.lower))
    bot_half = ((obj_bounds.upper > self.nodes[3].node_bounds.upper) && (obj_bounds.lower < self.nodes[3].node_bounds.lower))
    r_half   = ((obj_bounds.right < self.nodes[0].node_bounds.right) && (obj_bounds.left  > self.nodes[0].node_bounds.left ))
    l_half   = ((obj_bounds.right < self.nodes[1].node_bounds.right) && (obj_bounds.left  > self.nodes[1].node_bounds.left ))
    
    error = top_half && bot_half || r_half && l_half
    if error
      puts "QUAD TREE IS BORKEN"
    end

    index = (top_half && r_half) ? 0 : index
    index = (top_half && l_half ) ? 1 : index
    index = (bot_half && l_half ) ? 2 : index
    index = (bot_half && r_half) ? 3 : index

    #index = (top_half    && r_half) ? self.nodes[0] : index
    #index = (top_half    && l_half ) ? self.nodes[1] : index
    #index = (bot_half && l_half ) ? self.nodes[2] : index
    #index = (top_half    && r_half) ? self.nodes[3] : index

    # Need to consider outlyer case if object moves past the edge of map where:
  end

  # obj_bounds passed for collition detection must be from the shape class
  def insert(obj_bounds)
    # rewrite the  next 6 lines to use a returned node instead of index for get quad
    unless self.nodes.empty?
      index = self.getQuad(obj_bounds)
      unless index == -1
        self.nodes[index].insert(obj_bounds)
      end
    end

    self.data_list << obj_bounds

    if ((self.data_list.length > @@max_data) && (self.level < @@max_level))
      if self.nodes.empty?
        self.branch
      end 

      i=0
      while i < self.data_list.size
        temp_obj = self.data_list[i]
        index = self.getQuad(temp_obj)
        puts index
        unless index == -1
          self.nodes[index].data_list << temp_obj
          self.data_list.delete_at(i)
        else
          i+=1
        end
      end
    end
=begin
      self.data_list.each{|thing| 
        index = self.getQuad(thing)
        unless index == -1
          self.nodes[index].data_list << thing
          # ERROR IS BELOW
          self.data_list.delete(thing)
        end
        }
    end
=end
  end

  # I feel like there is a faster way to do the retrieve by 
  # noting the position of each object in the tree.... 
  def retrieve(obj_bounds) #, return_data = Array.new)
    return_array = Array.new(self.data_list)
    unless self.nodes.empty?
      index = self.getQuad(obj_bounds)
      unless index == -1 
        return_array += self.nodes[index].retrieve(obj_bounds)
      end
    end
    return_array
  end

  # Function used for truble shooting, very expensive to use
  def get_node_bounds(return_bounds = Array.new)
    if self.nodes[0] != nil
      self.nodes[0].get_node_bounds(return_bounds)
      self.nodes[1].get_node_bounds(return_bounds)
      self.nodes[2].get_node_bounds(return_bounds)
      self.nodes[3].get_node_bounds(return_bounds)
    end
    return_bounds << self.node_bounds 
  end
  
  def get_nodes(node_list = Array.new)
    unless self.nodes.empty?
      self.nodes[0].get_nodes(node_list)
      self.nodes[1].get_nodes(node_list)
      self.nodes[2].get_nodes(node_list)
      self.nodes[3].get_nodes(node_list)
    end
    node_list << self
  end

  def puts_nodes
    node_list = self.get_nodes
    i=0
    node_list.each{|thing| 
      if i==0
        puts "THE START: NODE INFO"
      end
      i+=1
      puts "
            Lvl: #{thing.level}
            items: #{thing.data_list.length}
            detales: #{thing.data_list.inspect}
            location: #{thing.node_bounds.x} #{thing.node_bounds.y}
            "}
  end
end
