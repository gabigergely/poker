class Game
  
  attr_reader :player_one, :player_two

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
  end
  
  def play!(cards)
    hands = cards.split.each_slice(5).to_a
    player_one.deal_a_hand(hands[0])
    player_two.deal_a_hand(hands[1])
    
    winner = determine_winner(player_one, player_two)
    update_score(winner)
    
    # normally, return the winner, but this is a decorator
    
    {
      player_one: {
        cards: hands[0],
        hands: player_one.card.hands,
        score: player_one.score
      },
      player_two: {
        cards: hands[1],
        hands: player_two.card.hands,
        score: player_two.score
      },
      winner: (winner == player_one ? :player_one : :player_two)
    }
  end
  
  private
  
  def determine_winner(player_one, player_two)
    # converting hands to rankings
    p1_max = player_one.card.converted_hands.max.to_i
    p2_max = player_two.card.converted_hands.max.to_i
    
    if p1_max != p2_max
      return p1_max > p2_max ? player_one : player_two
    end

    # if hands are equal, compare highest cards
    compare_highest_card(player_one, player_two)
  end
  
  def compare_highest_card(player_one, player_two)
    p1_values = player_one.card.values.sort.reverse
    p2_values = player_two.card.values.sort.reverse

    p1_values.zip(p2_values).each do |p1_card, p2_card|
      return player_one if p1_card > p2_card
      return player_two if p2_card > p1_card
    end

    # if all cards are equal then it's a tie
    nil
  end
  
  def update_score(winner)
    winner.score += 1 if winner
  end
end
