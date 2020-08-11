# frozen_string_literal: true

#
# File: grid.rb
# Author: Quentin Deschamps
# Date: August 2020
#

require 'gosu'
require 'astar_visualizer/node'

#
# The Grid class represents the grid. It is composed of nodes.
#
class Grid
  #
  # Builds the nodes of the grid. It returns the list of nodes.
  #
  def self.build_nodes(window, cols, rows, width, height)
    nodes = []
    rows.times do |y|
      nodes << []
      cols.times do |x|
        nodes[y] << Node.new(window, x, y, width, height)
      end
    end
    nodes
  end

  #
  # Creates the grid with the nodes.
  #
  def initialize(window, cols, rows, size)
    @window = window
    @cols = cols
    @rows = rows
    @width = size / cols    # width of a node's square
    @height = size / rows   # height of a node's square
    @nodes = Grid.build_nodes(window, cols, rows, @width, @height)
    @color = Gosu::Color.argb(0xaad3d3d3)
  end

  #
  # Returns a node from the grid.
  #
  def node(x, y)
    @nodes[y][x]
  end

  #
  # Yields all nodes of the grid.
  #
  def each_node
    @rows.times do |y|
      @cols.times do |x|
        yield node(x, y)
      end
    end
  end

  #
  # Returns if the (x, y) position is in the grid.
  #
  def inside?(x, y)
    x >= 0 && x < @cols && y >= 0 && y < @rows
  end

  #
  # Returns if a node is walkable.
  #
  def walkable?(x, y)
    inside?(x, y) && !node(x, y).obstacle?
  end

  #
  # Updates the neighbors of all nodes.
  #
  def update_neighbors
    each_node do |node|
      x = node.x
      y = node.y
      node.neighbors.clear
      node.add_to_neighbors(node(x, y - 1)) if walkable?(x, y - 1)  # ↑
      node.add_to_neighbors(node(x + 1, y)) if walkable?(x + 1, y)  # →
      node.add_to_neighbors(node(x, y + 1)) if walkable?(x, y + 1)  # ↓
      node.add_to_neighbors(node(x - 1, y)) if walkable?(x - 1, y)  # ←
    end
  end

  #
  # Resets all the nodes.
  #
  def reset!
    each_node(&:reset!)
  end

  #
  # Draws the lines of the grid.
  #
  def draw_grid
    @rows.times do |i|  # horizontal
      x1 = 0
      y1 = @height * i
      x2 = @width * @cols
      y2 = @height * i
      @window.draw_line(x1, y1, @color, x2, y2, @color)
    end
    @cols.times do |i|  # vertical
      x1 = @width * i
      y1 = 0
      x2 = @width * i
      y2 = @height * @rows
      @window.draw_line(x1, y1, @color, x2, y2, @color)
    end
  end

  #
  # Draws the nodes and the grid.
  #
  def draw
    each_node(&:draw)
    draw_grid
  end

  #
  # Finds a node in the grid using mouse position.
  #
  def find_node(mouse_x, mouse_y)
    each_node do |node|
      return node if node.inside?(mouse_x, mouse_y)
    end
    nil
  end
end
