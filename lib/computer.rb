class Computer
  attr_reader :name, :guess

  def initialize(name = 'HP-all-in-one')
    @name = name
    @guess = nil
    @available_colors = %w[red green blue yellow orange purple]
  end

  def make_guess
    @guess = Array.new(4) { @available_colors.sample }
    puts "#{@name} guesses: #{@guess.join(' ')}"
    @guess
  end
end
