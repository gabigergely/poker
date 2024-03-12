class GamesController < ApplicationController  
  before_action :set_game

  def index
    @results = []
    
    lines = File.readlines('./poker.txt')
    lines.each do |cards|
      @results << @game.play!(cards)
    end
  end

  private

  def set_game
    player_one = Player.new
    player_two = Player.new
    @game = Game.new(player_one, player_two)
  end
end
