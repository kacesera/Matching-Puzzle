require 'colorize'

class Card
    attr_reader :face_value, :current_value, :hidden_value, :showing_card

    def initialize(card_value)
        @face_value = card_value.colorize(:light_blue)
        @showing_card = false
        @hidden_value = "+"
    end

    def display_card
        if @showing_card == false
            hidden_value
        else
            face_value
        end
    end

    def hide_card
        @showing_card = false
        hidden_value
    end

    def reveal
        @showing_card = true
        face_value
    end

    def ==(other_card)
        self.face_value == other_card.face_value
    end   
end
