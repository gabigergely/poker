class Card
  attr_reader :values, :colors, :hands
  attr_reader :same_suit, :duplicates
  
  CARDS = {
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14
  }

  RANKINGS = %w{
    one_pair
    two_pairs
    three_of_a_kind
    straight
    flush
    full_house
    four_of_a_kind
    straight_flush
    royal_flush
  }

  def initialize
    @values     = []
    @colors     = []
    @hands      = []
    @same_suit  = false
    @duplicates = {}
  end
  
  def evaluate_cards(array_of_str)
    assign_cards(array_of_str)
  end
  
  def converted_hands
    hands.map{ |h| RANKINGS.index(h) + 1 }
  end
  
  private
  
  def assign_cards(array_of_str)
    array_of_str.each do |h|
      values << CARDS[h[0]]
      colors << h[1]
    end
    
    assess_cards
    evaluate_hand
  end
  
  def assess_cards
    return if values.empty?
    return unless values.size == 5
    
    @same_suit = (colors.uniq.size == 1)
    duplicates = find_duplicates
  end
  
  def evaluate_hand
    if same_suit
      hands << "flush"
      hands << "staight_flush" if is_straight_flush?
      hands << "royal_flush" if is_royal_flush?
    end
    
    hands << "one_pair" if is_one_pair?
    hands << "two_pairs" if is_two_pairs?
    hands << "three_of_a_kind" if is_three_of_a_kind?
    hands << "full_house" if is_three_of_a_kind? && is_one_pair?
    hands << "four_of_a_kind" if is_four_of_a_kind?
    hands << "straight" if is_straight?
    
    hands
  end
  
  def find_duplicates
    return if values == values.uniq # no duplicates
    
    values.each do |card|
      next if duplicates.has_key?(card)
      duplicates[card] = values.count(card) if values.count(card) > 1
    end  
  end
  
  def is_consecutive?
    values.sort.each_cons(2).all?{|a, b| b == a + 1 }
  end
  
  def is_straight?
    is_consecutive?
  end
  
  def is_straight_flush?
    same_suit && is_consecutive?
  end
  
  def is_royal_flush?
    return unless is_straight_flush?
    values.sort[0] == 10
  end
  
  def is_one_pair?
    duplicates.values.select{|c| c == 2}.count == 1
  end

  def is_two_pairs?
    duplicates.values.select{|c| c == 2}.count == 2
  end

  def is_three_of_a_kind?
    duplicates.values.select{|c| c == 3}.count == 1
  end

  def is_four_of_a_kind?
    duplicates.values.select{|c| c == 4}.count == 1
  end
end
