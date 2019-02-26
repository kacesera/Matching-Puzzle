require_relative "game"
require 'byebug'

system("clear")
puts "Are you ready for a game of Matching?"
sleep(1)
puts
puts "Type 'computer' to watch the computer play!"
puts "Or, enter your name to play:"
name = gets.chomp
system("clear")
puts "Enter number of rows (even numbers only):"
grid_size = gets.chomp
system("clear")

game = Game.new(name, grid_size)
game.make_board

until game.over?
    game.play_game
end

puts "Congratulations! You've matched all of the cards!"
sleep(2)
system("clear")
