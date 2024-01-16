# frozen_string_literal: true

require_relative './grid'

# Where the logic of the interaction user/grid occurs
class Game
  attr_accessor :grid

  def initialize
    @grid = Grid.new
  end

  def ask_user_move
    grid = @grid.grid
    loop do
      puts 'Choose a column (from 1 to 7)'
      move = gets
      column = move - 1 if move.is_a? Integer
      return column if column && grid[column][grid[column].index(nil)].nil?

      puts 'Can\'t do that! Pick a better spot!'
    end
  end

  def play_game
    loop do
      @grid.draw_grid
    end
  end
end
