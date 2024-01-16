# frozen_string_literal: true

require_relative '../lib/grid'

HEART = "\u2665"
DIAMOND = "\u2666"
EMPTY = nil

describe Grid do
  describe '#check_column_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid) { described_class.new }

      it 'returns nil' do
        expect(grid.check_column_winner).to eql(nil)
      end
    end

    context 'when there are four consecutive pieces' do
      g = Array.new(6) { Array.new(6) { EMPTY } }
      g << [HEART, HEART, HEART, HEART, EMPTY, EMPTY]
      subject(:grid) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid.check_column_winner).to eql(HEART)
      end
    end
  end

  describe '#check_row_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid) { described_class.new }

      it 'returns nil' do
        expect(grid.check_row_winner).to eql(nil)
      end
    end

    context 'when there are four consecutive pieces' do
      g = []
      g << [DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY]
      4.times { g << [EMPTY, DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY] }
      2.times { g << [DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
      subject(:grid) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid.check_row_winner).to eql(DIAMOND)
      end
    end
  end

  describe '#check_diagonal_winner' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid) { described_class.new }

      it 'returns nil' do
        expect(grid.check_diagonal_winner).to eql(nil)
      end
    end

    context 'when there are four consecutive pieces' do
      g = []
      g << [HEART, DIAMOND, EMPTY, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, HEART, EMPTY, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, DIAMOND, HEART, EMPTY, EMPTY, EMPTY]
      g << [DIAMOND, DIAMOND, HEART, HEART, EMPTY, EMPTY]
      3.times { g << [HEART, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY] }
      subject(:grid) { described_class.new(g) }

      it 'returns the winner' do
        expect(grid.check_diagonal_winner).to eql(HEART)
      end
    end
  end

  describe '#check_winner' do
    context 'where there is no winner' do
      subject(:grid) { described_class.new }

      it 'returns nil' do
        expect(grid.check_winner).to eql(nil)
      end
    end

    context 'when there is a winner' do
      subject(:grid) { described_class.new }

      before do
        allow(grid).to receive(:check_row_winner).and_return(HEART)
      end

      it 'returns the winner' do
        expect(grid.check_winner).to eql(HEART)
      end
    end
  end

  describe '#game_over?' do
    context 'if the game is not over' do
      subject(:grid) { described_class.new }

      it 'returns false' do
        expect(grid).not_to be_game_over
      end
    end

    context 'if the game is over' do
      g = []
      7.times { g << [HEART, DIAMOND, HEART, DIAMOND, HEART, DIAMOND] }
      subject(:grid) { described_class.new(g) }

      it 'returns true' do
        expect(grid).to be_game_over
      end
    end
  end

  describe '#set_current_player' do

  end

  describe '#make_move' do
    subject(:grid) { described_class.new }
    let(:column) { 3 }

    xit 'adds a piece in the correct place' do
      expect(grid.make_move(column))
    end
  end
end
