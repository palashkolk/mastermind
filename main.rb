require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/player'

new_game = Game.new
new_game.play

loop do
  puts "\n" + '*' * 50 + "\n"
  puts 'Do you want to play another game? (y/n)'

  reply = gets.chomp.downcase
  break unless reply == 'y'

  another_game = Game.new
  new_game.play
end
