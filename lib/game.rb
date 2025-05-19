require_relative 'computer'
require_relative 'player'

class Game
  def initialize
    puts 'Welocome to the game of Mastermind'
    puts 'How would you like to play?'
    puts '1. You are the codebreaker (Computer makes the code)'
    puts '2. You makes the code and computer breaks it!'
    @game_mode = get_game_mode
    setup_game
  end

  def play
    puts 'Game is starting'
    puts "You have #{@max_attempts} attempts"

    loop do
      puts "Attempt #{@current_attempt + 1}/#{@max_attempts}"
      guess = @guesser.make_guess
      result = make_guess(guess)
      if result.is_a?(String)
        puts result
        break
      else
        puts "feedback: #{result[:black]} black pegs, #{result[:white]} white pegs"
        puts 'Black pegs = Correct color and position, White pegs = Correct color wrong position'
      end
    end
  end

  def make_guess(player_guess)
    @current_attempt += 1
    if @current_attempt > @max_attempts
      "Game over! Maximum limit is reached. #{@guesser.name} has lost. The secret code is #{@secret_code.join(' ')}"
    elsif player_guess == @secret_code
      "Congrats!  #{@guesser.name} have rightly guessed the code #{@secret_code.join(' ')} in #{@current_attempt} attempts"
    else
      generate_feedback(player_guess)
    end
  end

  def generate_feedback(player_guess)
    total_color_matches = 0
    black_pegs = 0

    player_guess.each_with_index do |guess, index|
      black_pegs += 1 if guess == @secret_code[index]
    end

    @available_colors.each do |color|
      secret_count = @secret_code.count(color)
      player_count = player_guess.count(color)
      total_color_matches += [secret_count, player_count].min
    end
    white_pegs = total_color_matches - black_pegs
    { black: black_pegs, white: white_pegs }
  end

  def get_game_mode
    loop do
      puts 'Enter either 1 or 2 as your choice:'
      choice = gets.chomp.to_i
      return choice if [1, 2].include?(choice)

      puts 'Invalide choice!'
    end
  end

  def setup_game
    @max_attempts = 12
    @current_attempt = 0
    @available_colors = %w[red green blue orange yellow purple]
    if @game_mode == 1
      @guesser = Computer.new
      @secret_code = create_own_secret_code
    elsif @game_mode == 2
      @guesser = Player.new('Sabir')
      @secret_code = generate_secret_code
      puts 'Computer has created a secret code of 4 colors. Try to guess it'
    end
  end

  def generate_secret_code
    Array.new(4) { @available_colors.sample }
  end

  def create_own_secret_code
    puts 'Enter your secret code of 4 colors separated by space'
    puts "Available colors: #{@available_colors.join(' ')}"
    loop do
      input = gets.chomp.downcase.split
      return input if input.length == 4 && input.all? { |color| @available_colors.include?(color) }

      puts 'Invalid input. Please enter exactly 4 valid colors from above'
    end
  end
end
