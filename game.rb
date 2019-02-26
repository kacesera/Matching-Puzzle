require_relative "board"
require_relative "HumanPlayer"

require 'byebug'

class Game
    attr_reader :board, :matches, :player, :revealed_cards

    def initialize(name, grid_size)
        @player = HumanPlayer.new(name, grid_size.to_i)
        @board = Board.new(grid_size.to_i)
        @revealed_cards = Hash.new(0)
        @guesses = []
        @matches = 0
    end

    def over?
        matches == board.num_to_match
    end

    def make_board
        board.populate_grid
    end

    def take_turn
        guess = player.get_guess

        if player.name == 'COMPUTER'
            sleep(1)
        end

        if reveal(guess)
            return true
        else
            take_turn
        end
    end

    def play_game
        #debugger
        2.times do 
            board.render
            take_turn
            system("clear")
        end

        player.receive_revealed_cards(@revealed_cards)

        board.render
        sleep(1)
        puts

        if matching?
            revealed_cards.delete(@guesses.first)
            @guesses = []
            @matches += 1
            puts "There's a match!"
        else
            hide_flipped_cards(@guesses.first, @guesses.last)
            @guesses = []
            puts "The cards don't match :("
        end

        sleep(2)
        system("clear")
    end

    def row_col_guess(entry)
        string_nums = entry.split(",")
        string_nums.each.reduce([]) do |nums, num|
            nums << num.to_i
        end
    end

    def matching?
        card_1, card_2 = @guesses.first, @guesses.last
        if card_1.face_value == card_2.face_value
            return true
        else
            return false
        end
    end

    def reveal(guessed_pos)
        guessed_coords = row_col_guess(guessed_pos)
        row, col = guessed_coords[0], guessed_coords[1]
        current_card = board.grid[row][col]

        if already_flipped?(guessed_coords)
            if player.name != 'COMPUTER'
                puts "Card already flipped over!"
            end
            system("clear")
            board.render
            return false
        end

        @guesses << current_card
        enter_revealed_cards(current_card.face_value, guessed_pos)
        current_card.reveal
        current_card.display_card
 
        return true
    end

    def hide_flipped_cards(card1, card2)
        card1.hide_card
        card1.display_card
        card2.hide_card
        card2.display_card
    end

    def already_flipped?(position)
        row, col = position[0], position[1]
        board.grid[row][col].showing_card
    end

    def enter_revealed_cards(card, position)
        position = [position]
        if revealed_cards[card] == 0
            revealed_cards[card] = position
        elsif !revealed_cards.value?(position)
            revealed_cards[card] += position
        else
            return false
        end
    end



end

