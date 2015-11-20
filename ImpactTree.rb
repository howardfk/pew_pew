require 'singlton'
# ImpactTree is a quad tree used to determing most likely Impacs between objects in 2D space
class ImpactTree
  include Singleton

  attr_accessor :level, :node_bounds

  def initialze(level, node_bounds)
    
  end

  def clear
  end

  def split 
  end

  def getIndex
  end

  def insert
  end

  def retrieve
  end

end
