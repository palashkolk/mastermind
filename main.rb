require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/computer'

game = Game.new
game.play

puts 'Would you like to play again? (y/n)'
if gets.chomp.downcase == 'y'
  puts "\n" + '=' * 50 + "\n"
  new_game = Game.new
  new_game.play
end

puts 'Thanks for playing Mastermind'
