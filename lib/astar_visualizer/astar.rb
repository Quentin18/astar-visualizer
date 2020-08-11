# frozen_string_literal: true

#
# File: astar.rb
# Author: Quentin Deschamps
# Date: August 2020
#

require 'gosu'
require 'astar_visualizer/grid'

#
# The AStar class manages the window with the grid and can launch
# the A* algorithm.
#
class AStar < Gosu::Window
  # Size of the grid in pixels.
  SIZE_GRID = 700

  # Height of the informations block in pixels.
  HEIGHT_INFO_BLOCK = 40

  # Number of columns in the grid.
  COLS = 50

  # Number of lines in the grid.
  ROWS = 50

  #
  # Creates the window with its grid.
  #
  def initialize
    super(SIZE_GRID, SIZE_GRID + HEIGHT_INFO_BLOCK, false)
    self.caption = 'A* Pathfinding Visualizer'
    @font = Gosu::Font.new(28)
    @message = 'Choose the start node.'
    @grid = Grid.new(self, COLS, ROWS, SIZE_GRID)
    @start = @end = nil
    @needs_reset = false
  end

  #
  # To show the mouse cursor on the window.
  #
  def needs_cursor?
    true
  end

  #
  # Returns if the A* algorithm can be launched.
  #
  def ready?
    !@needs_reset && @start && @end
  end

  #
  # Resets the start node.
  #
  def reset_start!
    @start = nil
  end

  #
  # Resets the end node.
  #
  def reset_end!
    @end = nil
  end

  #
  # Resets the window.
  #
  def reset!
    reset_start!
    reset_end!
    @grid.reset!
    @needs_reset = false
  end

  #
  # Gets the button down. Two different actions:
  #
  # * *ENTER*: launch A* algorithm
  # * *SUPPR*: clear window
  #
  def button_down(id)
    # ENTER: launch A* algorithm
    if id == Gosu::KbReturn && ready?
      @grid.update_neighbors
      a_star
      @needs_reset = true
    end

    # SUPPR: clear window
    reset! if id == Gosu::KbDelete
  end

  #
  # Finds the node in the grid corresponding to the mouse position.
  #
  def find_node
    @grid.find_node(self.mouse_x, self.mouse_y)
  end

  #
  # Updates the window. If the mouse buttons are used, it updates nodes and
  # the message in the informations block.
  #
  def update
    return if @needs_reset

    # Message
    if !@start
      @message = 'Choose the start node.'
    elsif !@end
      @message = 'Choose the end node.'
    else
      @message = 'Add obstacles and press ENTER.'
    end

    if Gosu.button_down? Gosu::MsLeft
      node = find_node
      if node
        # Make start node
        if !@start && node != @end
          node.start!
          @start = node
        # Make end node
        elsif !@end && node != @start
          node.end!
          @end = node
        # Make obstacle
        elsif node != @start && node != @end
          node.obstacle!
        end
      end
    end

    # Clear a node
    if Gosu.button_down? Gosu::MsRight
      node = find_node
      if node
        node.reset!
        if node == @start
          reset_start!
        elsif node == @end
          reset_end!
        end
      end
    end
  end

  #
  # Draws the grid and the informations block.
  #
  def draw
    @grid.draw
    show_info
  end

  #
  # Shows the informations block.
  #
  def show_info
    @font.draw_text(@message, 10, SIZE_GRID + 8, 5)
  end

  #
  # Reconstructs the path found by coloring the nodes.
  #
  def reconstruct_path(came_from, current)
    while came_from.include?(current)
      current = came_from[current]
      current.path!
    end
    @start.start!
    @end.end!
  end

  #
  # Launchs the A* algorithm.
  #
  def a_star
    open_set = [@start]
    came_from = {}
    g_score = {}
    f_score = {}
    @grid.each_node do |node|
      g_score[node] = Float::INFINITY
      f_score[node] = Float::INFINITY
    end
    g_score[@start] = 0
    f_score[@start] = h(@start)

    until open_set.empty?
      current = open_set[0]
      open_set.each do |node|
        current = node if f_score[node] < f_score[current]
      end

      if current == @end
        reconstruct_path(came_from, current)
        @message = 'Path found! Press SUPPR to clear the window.'
        return true
      end

      current = open_set.delete_at(open_set.index(current))

      current.neighbors.each do |neighbor|
        tentative_g_score = g_score[current] + 1
        next if tentative_g_score >= g_score[neighbor]

        came_from[neighbor] = current
        g_score[neighbor] = tentative_g_score
        f_score[neighbor] = g_score[neighbor] + h(neighbor)
        unless open_set.include?(neighbor)
          open_set << neighbor
          neighbor.open!
        end
      end

      current.closed! if current != @start
    end
    @message = 'No path found! Press SUPPR to clear the window.'
    false
  end

  #
  # Heuristic function used : Manhattan distance.
  #
  def h(node)
    (node.x - @end.x).abs + (node.y - @end.y).abs
  end
end
