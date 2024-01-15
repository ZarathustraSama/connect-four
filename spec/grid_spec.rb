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
end
