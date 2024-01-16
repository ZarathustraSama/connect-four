# frozen_string_literal: true

require_relative './grid'

# Where the logic of the interaction user/grid occurs
class Game
  attr_accessor :grid

  def initialize(grid = Grid.new)
    @grid = grid
  end

  def ask_user_move
    grid = @grid.grid
    loop do
      puts 'Choose a column (from 1 to 7)'
      move = gets.chomp.to_i
      column = move - 1 if (move - 1).positive?
      return column if column && grid[column][grid[column].index(nil)].nil?

      puts 'Can\'t do that! Pick a better spot!'
    end
  end

  def play_game
    loop do
      #@grid.draw_grid
      if @grid.game_over?
        winner = @grid.check_winner
        return winner.nil? ? puts('Game Over: It\'s a draw!') : puts("Game Over: #{winner} wins!")
      else
        puts "Player #{@grid.set_current_player}'s turn"
      end
      @grid = @grid.make_move(ask_user_move, @grid.set_current_player)
    end
  end
end
