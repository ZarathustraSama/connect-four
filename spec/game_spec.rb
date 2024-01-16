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
  end
end
