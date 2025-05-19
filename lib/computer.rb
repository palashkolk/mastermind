class Computer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_guess
    available_colors = %w[red blue green orange yellow purple]
    Array.new(4) { available_colors.sample }
  end
end
