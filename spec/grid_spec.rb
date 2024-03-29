# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  describe '#check_column_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid_win_column) { described_class.new }

      it 'returns nil' do
        expect(grid_win_column.check_column_winner).to be_nil
      end
    end

    context 'when there are four consecutive pieces' do
      g = Array.new(6) { Array.new(6) { EMPTY } }
      g << [HEART, HEART, HEART, HEART, EMPTY, EMPTY]
      subject(:grid_win_column) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid_win_column.check_column_winner).to eql(HEART)
      end
    end
  end

  describe '#check_row_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid_win_row) { described_class.new }

      it 'returns nil' do
        expect(grid_win_row.check_row_winner).to be_nil
      end
    end

    context 'when there are four consecutive pieces' do
      g = []
      g << [DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY]
      4.times { g << [EMPTY, DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY] }
      2.times { g << [DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
      subject(:grid_win_row) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid_win_row.check_row_winner).to eql(DIAMOND)
      end
    end
  end

  describe '#check_diagonal_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid_win_diagonal) { described_class.new }

      it 'returns nil' do
        expect(grid_win_diagonal.check_diagonal_winner).to be_nil
      end
    end

    context 'when there are four consecutive pieces' do
      g = []
      g << [HEART, DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, HEART, EMPTY, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, DIAMOND, HEART, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, DIAMOND, HEART, HEART, EMPTY, EMPTY]
      3.times { g << [HEART, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
      subject(:grid_win_diagonal) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid_win_diagonal.check_diagonal_winner).to eql(HEART)
      end
    end
  end

  describe '#check_winner' do
    context 'where there is no winner' do
      subject(:grid_win) { described_class.new }

      it 'returns nil' do
        expect(grid_win.check_winner).to be_nil
      end
    end

    context 'when there is a winner' do
      subject(:grid_win) { described_class.new }

      before do
        allow(grid_win).to receive(:check_row_winner).and_return(HEART)
      end

      it 'returns the winner' do
        expect(grid_win.check_winner).to eql(HEART)
      end
    end
  end

  describe '#game_over?' do
    context 'if the game is not over' do
      subject(:grid_over) { described_class.new }

      it 'returns false' do
        expect(grid_over).not_to be_game_over
      end
    end

    context 'if the game is over, but nobody won' do
      g = []
      7.times { g << [HEART, DIAMOND, HEART, DIAMOND, HEART, DIAMOND] }
      subject(:grid_over) { described_class.new(g) }

      it 'returns true' do
        expect(grid_over).to be_game_over
      end
    end

    context 'if somebody won' do
      subject(:grid_over) { described_class.new }

      before do
        allow(grid_over).to receive(:check_winner).and_return(DIAMOND)
      end

      it 'returns true' do
        expect(grid_over).to be_game_over
      end
    end
  end

  describe '#set_current_player' do
    context 'if the game begun' do
      subject(:grid_start) { described_class.new }

      it 'returns the HEART player' do
        expect(grid_start.set_current_player).to eql(HEART)
      end
    end

    context 'in the middle of the game' do
      g = []
      g << [HEART, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY]
      6.times { g << [EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
      subject(:grid_mid) { described_class.new(g) }

      it 'returns the next player (DIAMOND)' do
        expect(grid_mid.set_current_player).to eql(DIAMOND)
      end
    end

    context 'at the end of the game' do
      g = []
      7.times { g << [HEART, DIAMOND, HEART, DIAMOND, HEART, DIAMOND] }
      subject(:grid_end) { described_class.new(g) }

      before do
        allow(grid_end).to receive(:game_over?).and_return(true)
      end

      it 'returns nil' do
        expect(grid_end.set_current_player).to be_nil
      end
    end
  end

  describe '#make_move' do
    subject(:grid) { described_class.new }
    let(:column) { 3 }
    let(:player) { HEART }
    g = []
    3.times { g << [EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
    g << [HEART, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY]
    3.times { g << [EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }

    it 'adds a piece in the correct place' do
      expect(grid.make_move(column, player).grid).to eql(g)
    end
  end
end
