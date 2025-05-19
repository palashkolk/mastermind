require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/player'

new_game = Game.new
new_game.play

puts 'Do you want to play another game? (y/n)'

reply = gets.chomp.downcase
if reply == 'y'
  puts "\n" + '=' * 50 + "\n"
  another_game = Game.new
  another_game.play
end
