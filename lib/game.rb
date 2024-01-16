# frozen_string_literal: true

require_relative './grid'

# Where the logic of the interaction user/grid occurs
class Game
  attr_accessor :grid

  def initialize(grid = Grid.new)
    @grid = grid
  end

  def ask_user_move
    loop do
      puts 'Choose a column (from 1 to 7)'
      move = gets.chomp.to_i - 1
      return move if valid_move?(move)

      puts 'Can\'t do that! Pick a better spot!'
    end
  end

  def play_game
    loop do
      @grid.draw_grid
      player = @grid.set_current_player
      if @grid.game_over?
        winner = @grid.check_winner
        return winner.nil? ? puts('Game Over: It\'s a draw!') : puts("Game Over: #{winner} wins!")
      else
        puts "Player #{player}'s turn"
      end
      @grid = @grid.make_move(ask_user_move, player)
    end
  end

  private

  def valid_move?(move)
    grid = @grid.grid
    begin
      grid[move][grid[move].index(nil)]
    rescue TypeError
      false
    else
      move < 7 && move >= 0 && grid[move][grid[move].index(nil)].nil?
    end
  end
end
