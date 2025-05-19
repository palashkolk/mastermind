class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess
    available_colors = %w[red blue green orange yellow purple]
    puts "\nEnter 4 colors from: #{available_colors.join(' ')}"
    gets.chomp.downcase.split(' ')
  end
end
