# frozen_string_literal: true

HEART = "\u2665"
DIAMOND = "\u2666"
EMPTY = nil

# Where the game takes place
class Grid
  attr_accessor :grid

  def initialize(grid = initial_state)
    @grid = grid
  end

  def check_column_winner
    @grid.each do |column|
      column.each_cons(4) do |a|
        return a[0] if a.uniq.size == 1 && a[0] != EMPTY
      end
    end
    nil
  end

  private

  def initial_state
    Array.new(7) { Array.new(6) { EMPTY } }
  end
end
