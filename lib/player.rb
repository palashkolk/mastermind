class Player
  attr_reader :name, :guess

  def initialize(name)
    @name = name
    @guess = nil
  end

  def make_guess
    puts 'Enter four color sparated by space'
    puts 'Available colors: red, blue, green, orange, purple, yellow'
    input = gets.chomp.downcase.split
    @guess = input
    @guess
  end
end
