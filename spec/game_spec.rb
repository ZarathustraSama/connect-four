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

  describe '#play_game' do
    let(:grid) { instance_double(Grid) }
    subject(:game_play) { described_class.new(grid) }

    context 'If the game is over after someone won' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:game_over?).and_return(true)
        allow(grid).to receive(:check_winner).and_return(HEART)
      end

      it 'shows the winner (HEART) on console' do
        winner_message = "Game Over: #{HEART} wins!"
        expect(game_play).to receive(:puts).with(winner_message).once
        game_play.play_game
      end
    end

    context 'If the game is over and nobody won' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:game_over?).and_return(true)
        allow(grid).to receive(:check_winner).and_return(nil)
      end

      it 'shows the "draw" message on console' do
        draw_message = 'Game Over: It\'s a draw!'
        expect(game_play).to receive(:puts).with(draw_message).once
        game_play.play_game
      end
    end

    context 'If the game doesn\'t end for two more turns' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:game_over?).and_return(false, false, true)
        allow(grid).to receive(:check_winner).and_return(DIAMOND)
        allow(grid).to receive(:make_move).and_return(grid, grid)
        allow(grid).to receive(:set_current_player).and_return(HEART, HEART, DIAMOND, DIAMOND)
        allow(game_play).to receive(:ask_user_move).and_return(3, 4)
      end

      it 'shows the "player\'s turn" message twice' do
        heart_player_message = "Player #{HEART}'s turn"
        diamond_player_message = "Player #{DIAMOND}'s turn"
        winner_message = "Game Over: #{DIAMOND} wins!"
        expect(game_play).to receive(:puts).with(heart_player_message).once
        expect(game_play).to receive(:puts).with(diamond_player_message).once
        expect(game_play).to receive(:puts).with(winner_message).once
        game_play.play_game
      end
    end
  end
end
