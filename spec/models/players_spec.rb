require 'rails_helper'

RSpec.describe Player do
  let(:player) { Player.new }

  describe "#initialize" do
    it "initializes with score zero" do
      expect(player.score).to eq(0)
    end
  end

  describe "detecting hands" do
    [
     [["one_pair"], ["4C", "QS", "QC", "AC", "KH"]],
     [["two_pairs"],  ["6S", "8D", "4C", "8S", "6C"]],
     [["three_of_a_kind"],  ["9S", "9D", "9C", "AC", "3D"]],
     [["straight"],  ["TS", "8H", "9S", "6S", "7S"]],
     [["flush"],  ["2S", "8S", "9S", "4S", "7S"]],
     [["one_pair", "three_of_a_kind", "full_house"],  ["9S", "9D", "9C", "8S", "8D"]],
     [["four_of_a_kind"],  ["9S", "9D", "9C", "9H", "8D"]],
     [["flush", "staight_flush", "straight"],  ["TS", "8S", "9S", "6S", "7S"]],
     [["flush", "staight_flush", "royal_flush", "straight"],  ["TS", "JS", "KS", "AS", "QS"]]
    ].each do |pair|
      
      context "when cards contain #{pair[0]}" do
        it "returns #{pair[0]}" do        
          player.deal_a_hand(pair[1])
          expect(player.card.hands).to eq(pair[0])
        end
      end
      
    end
  end
end
