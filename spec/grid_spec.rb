# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  describe '#column_win?' do
    context 'when there aren\'t four consecutive pieces' do
      subject(:grid) { described_class.new }

      it 'returns false' do
        expect(grid.check_win_row).to eql(false)
      end
    end
  end
end
