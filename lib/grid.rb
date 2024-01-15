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
        return a[0] if a.uniq.count == 1 && a[0] != EMPTY
      end
    end
    nil
  end

  def check_row_winner
    @grid.each_cons(4) do |group|
      group.each do |row|
        row.each_with_index do |cell, i|
          return cell if [group[0][i], group[1][i], group[2][i], group[3][i]].uniq.count == 1 && cell != EMPTY
        end
      end
    end
    nil
  end

  private

  def initial_state
    Array.new(7) { Array.new(6) { EMPTY } }
  end
end
