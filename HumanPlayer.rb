require_relative "game"
require_relative "computer"

class HumanPlayer
    attr_reader :name, :matches, :computer

    def initialize(name, size)
        @name = name.upcase
        @computer = Computer.new(size)
    end

    def is_computer?
        name == "COMPUTER"
    end

    def get_guess
        if is_computer?
            return computer.make_guess
        else
            puts
            puts "#{name}, enter your guess in this format: row, column"
            gets.chomp
        end
    end

    def receive_revealed_cards(cards)
        computer.receive_revealed_cards(cards)
    end


end
