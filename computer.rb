require_relative "board"
require "byebug"

class Computer
    attr_reader :known_cards, :matching_cards, :matches

    def initialize(board_size)
        @known_cards = Hash.new(0)
        @matching_cards = []
        @board_size = board_size
    end

    def receive_revealed_cards(revealed_cards)
        @known_cards = revealed_cards
    end

    def enter_location(new_location)
        known_cards.each do |card, location|
            location.each do |place|
                if location.count < 2
                    known_cards[card] = place, new_location
                end
            end
        end
    end

    def any_matching?
        if matching_cards.length < 2
            known_cards.each do |card, location|
                if location.count == 2
                    location.each {|coord| matching_cards << coord}
                    known_cards.delete(card)
                    return true
                end
            end 
        end 
        return false
    end

    def make_guess
        any_matching?
        if !matching_cards.empty?
            matching_cards.delete(matching_cards[0])
        else
            row = rand(0...@board_size)
            col = rand(0...@board_size)
            return "#{row},#{col}"
       end
    end

            

end
