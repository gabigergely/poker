require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe '#index' do
    let(:game) { instance_double(Game) }
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }
    let(:cards) { "8C TS KC 9H 4S 7D 2S 5D 3S AC\n" }
    let(:results) {
      {
        player_one: {
          cards: ["8C", "TS", "KC", "9H", "4S"],
          hands: [],
          score: 0
        },
        player_two: {
          cards: ["7D", "2S", "5D", "3S", "AC"],
          hands: [],
          score: 1
        },
        winner: :player_two
      }
    }

    before do
      allow(Player).to receive(:new).and_return(player_one, player_two)
      allow(Game).to receive(:new).with(player_one, player_two).and_return(game)
      allow(game).to receive(:play!).with(cards).and_return(results)
      allow(File).to receive(:readlines).with('./poker.txt').and_return([cards])
    end

    it 'calls set_game before index action' do
      expect(controller).to receive(:set_game).and_call_original
      get :index
    end

    it 'reads lines from poker.txt and calls play! on game object' do
      expect(game).to receive(:play!).with(cards).once
      get :index
    end

    it 'assigns results to @results' do
      get :index
      expect(assigns(:results)).not_to be_nil
    end
  end
end
