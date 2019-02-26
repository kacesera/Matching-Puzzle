require_relative "card"
require 'byebug'

class Board
    attr_reader :grid, :num_of_rows, :num_to_match

    def initialize(num_of_rows)
        @grid = Array.new(num_of_rows) {Array.new(num_of_rows, "")}
        @total_cards = num_of_rows ** 2
        @num_to_match = ""
    end

    def render
        puts "Matching Puzzle"
        puts
        grid.each do |row|
            values = row.map do |card|
                card.display_card
            end
            puts " #{values.join(" | ")}"
        end
    end

    def [](position)
        row, col = position
        @grid[row][col]
    end

    def get_cards
        deck = []
        total_pairs = @total_cards / 2

        @num_to_match = total_pairs

        while deck.length < @total_cards
            letter = ("1".."100").to_a.sample
            card1, card2 = letter, letter
            deck += [card1, card2] unless deck.include?(card1)
        end

        deck.shuffle!
        return deck
    end

    def populate_grid
        deck = get_cards

        grid.each_with_index do |row, row_idx|
            row.each_index do |col|
                break if deck.empty?
                card = deck.shift
                grid[row_idx][col] = Card.new(card)
            end
        end
    end

    def already_flipped?(row, col)
        grid[row][col].showing_card
    end
end