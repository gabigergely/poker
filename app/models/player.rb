class Player
  attr_reader :card
  attr_accessor :score
  
  def initialize
    @score = 0
  end

  def deal_a_hand(array_of_str)
    @card = Card.new
    card.evaluate_cards(array_of_str)
  end
end
