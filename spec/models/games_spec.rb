require 'rails_helper'

RSpec.describe Game do
  let(:player_one) { Player.new }
  let(:player_two) { Player.new }
  let(:game) { Game.new(player_one, player_two) }

  describe "#initialize" do
    it "initializes with the correct players" do
      expect(game.player_one).to eq(player_one)
      expect(game.player_two).to eq(player_two)
    end
  end

  describe "#play!" do
    context "when player one wins" do
      it "increments player one's score" do        
        game.play!("5C AD 5D AC 9C 7C 5H 8D TD KS\n")
        expect(player_one.score).to eq(1)
        expect(player_two.score).to eq(0)
      end
    end

    context "when player two wins" do
      it "increments player two's score" do
        game.play!("8C TS KC 9H 4S 7D 2S 5D 3S AC\n")
        expect(player_two.score).to eq(1)
        expect(player_one.score).to eq(0)
      end
    end
  end
end
