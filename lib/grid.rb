# frozen_string_literal: true

HEART = "\u2665"
DIAMOND = "\u2666"
EMPTY = nil

# Where the game takes place
class Grid
  def initialize
    @grid = initial_state
  end

  def column_win?
    @grid.each do |column|
      column.each_cons(4) do |a|
        return true if a.uniq == 1 && a[0] != EMPTY
      end
    end
    false
  end

  private

  def initial_state
    Array.new(7) { Array.new(6) { EMPTY } }
  end
end
