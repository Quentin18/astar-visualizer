# frozen_string_literal: true

#
# File: node.rb
# Author: Quentin Deschamps
# Date: August 2020
#

require 'gosu'

#
# The Node class represents the squares of the grid.
#
class Node
  # Gets the x position in the grid.
  attr_reader :x

  # Gets the y position in the grid.
  attr_reader :y

  # Gets the neighbors (list of nodes).
  attr_reader :neighbors

  #
  # Creates a node. It is composed of the (x, y) position in the grid and the
  # neighbors (list of nodes).
  #
  def initialize(window, x, y, width, height)
    @@colors ||= {
      green: Gosu::Color.argb(0xff00ff00),
      red: Gosu::Color.argb(0xffff0000),
      grey: Gosu::Color.argb(0xff808080),
      lightcyan: Gosu::Color.argb(0xffe0ffff),
      cyan: Gosu::Color.argb(0xff00ffff),
      white: Gosu::Color.argb(0xffffffff),
      yellow: Gosu::Color.argb(0xffffff00),
    }
    @@window ||= window
    @x = x
    @y = y
    @width = width
    @height = height
    @color = @@colors[:white]
    @neighbors = []
  end

  #
  # Returns if the node is the start point (green color).
  #
  def start?
    @color == @@colors[:green]
  end

  #
  # Makes a node the start point (green color).
  #
  def start!
    @color = @@colors[:green]
  end

  #
  # Returns if the node is the end point (red color).
  #
  def end?
    @color == @@colors[:red]
  end

  #
  # Makes a node the end point (red color).
  #
  def end!
    @color = @@colors[:red]
  end

  #
  # Returns if the node is an obstacle (grey color).
  #
  def obstacle?
    @color == @@colors[:grey]
  end

  #
  # Makes a node an obstacle (grey color).
  #
  def obstacle!
    @color = @@colors[:grey]
  end

  #
  # Returns if the node is in the open list (cyan color).
  #
  def open?
    @color == @@colors[:cyan]
  end

  #
  # Makes a node like in the open list (cyan color).
  #
  def open!
    @color = @@colors[:cyan]
  end

  #
  # Returns if the node is in the closed list (lightcyan color).
  #
  def closed?
    @color == @@colors[:lightcyan]
  end

  #
  # Makes a node like in the closed list (lightcyan color).
  #
  def closed!
    @color = @@colors[:lightcyan]
  end

  #
  # Resets a node (white color).
  #
  def reset!
    @color = @@colors[:white]
  end

  #
  # Makes a node in the found path (yellow color).
  #
  def path!
    @color = @@colors[:yellow]
  end

  #
  # Draws the square.
  #
  def draw
    @@window.draw_rect(@x * @width, @y * @height, @width, @height, @color)
  end

  #
  # Returns if the mouse position is in the square.
  #
  def inside?(mouse_x, mouse_y)
    pos_x = @x * @width
    pos_y = @y * @height
    mouse_x >= pos_x && mouse_x <= pos_x + @width && \
      mouse_y >= pos_y && mouse_y <= pos_y + @height
  end

  #
  # Adds a node to the neighbors list.
  #
  def add_to_neighbors(node)
    @neighbors << node
  end
end
