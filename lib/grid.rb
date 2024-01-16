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

  def check_diagonal_winner
    @grid[...-3].each do |row|
      row[...-3].each_with_index do |cell, i|
        return cell if diagonal_four?(i) && cell != EMPTY
      end
    end
    nil
  end

  def check_winner
    check_column_winner || check_row_winner || check_diagonal_winner
  end

  def game_over?
    check_winner || @grid.flatten.none?(nil) ? true : false
  end

  def set_current_player
    return HEART if @grid == initial_state
    return nil if game_over?

    @grid.flatten.count(HEART) > @grid.flatten.count(DIAMOND) ? DIAMOND : HEART
  end

  def make_move(column, player)
    @grid[column][@grid[column].index(EMPTY)] = player
    self
  end

  def draw_grid
    grid = Marshal.load(Marshal.dump(@grid))
    puts "\n---------------"
    until grid.flatten.empty?
      grid.each do |column|
        cell = column.pop
        cell.nil? ? print('| ') : print("|#{cell}")
      end
      print '|'
      puts "\n---------------"
    end
    puts "\n"
  end

  private

  def initial_state
    Array.new(7) { Array.new(6) { EMPTY } }
  end

  def diagonal_four?(ind)
    [@grid[ind][ind], @grid[ind + 1][ind + 1], @grid[ind + 2][ind + 2], @grid[ind + 3][ind + 3]].uniq.count == 1
  end
end
