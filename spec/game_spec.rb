# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/grid'

describe Game do
  describe '#ask_user_move' do
    context 'If the user gives the correct input' do
      subject(:game_input) { described_class.new }

      before do
        allow(game_input).to receive(:gets).and_return(5)
      end

      it 'returns 4' do
        expect(game_input.ask_user_move).to eql(4)
      end
    end

    context 'If the user gives two wrong inputs, then a correct one' do
      subject(:game_input) { described_class.new }

      before do
        allow(game_input).to receive(:gets).and_return('no', 'yes', 3)
      end

      it 'shows the error message twice' do
        standard_message = 'Choose a column (from 1 to 7)'
        error_message = 'Can\'t do that! Pick a better spot!'
        expect(game_input).to receive(:puts).with(error_message).twice
        expect(game_input).to receive(:puts).with(standard_message).exactly(3).times
        game_input.ask_user_move
      end
    end
  end
end
