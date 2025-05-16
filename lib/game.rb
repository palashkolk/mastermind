require_relative 'player'
require_relative 'computer'

class Game
  def initialize
    puts 'Welcome to the game of Mastermind.'
    puts 'Chose game mode:'
    puts '1. You guess and computer makes the code'
    puts '2. Computer guesses and you make the code'

    @game_mode = get_game_mode
    setup_game
  end

  def play
    puts "\nGame starting!"
    puts "You have #{@max_attempts} attempts."

    loop do
      puts "\nAttempt #{@current_attempt + 1}/#{@max_attempts}"
      guess = @guesser.make_guess
      result = make_guess(guess)

      if result.is_a?(String)
        puts result
        break
      else
        puts "feedback: #{result[:black]} black pegs, #{result[:white]} white pegs"
        puts 'Black = correct color and position, White = correct color, wrong position'
      end
    end
  end

  def make_guess(player_guess)
    @current_attempt += 1

    if player_guess == @secret_code
      puts "Congrats! #{@guesser.name} has won in #{@current_attempt}"
    elsif @current_attempt > @max_attempts
      "Game over! #{@guesser.name} has lost. The secret code was #{@secret_code.join(' ')}"
    else
      generate_feedback(player_guess)

    end
  end

  def generate_feedback(player_guess)
    black_pegs = 0

    player_guess.each_with_index do |color, index|
      black_pegs += 1 if color == @secret_code[index]
    end

    total_color_matches = 0
    @available_colors.each do |color|
      secret_count = @secret_code.count(color)
      guess_count = player_guess.count(color)
      total_color_matches += [secret_count, guess_count].min
    end

    white_pegs = total_color_matches - black_pegs
    { black: black_pegs, white: white_pegs }
  end

  def get_game_mode
    loop do
      puts 'Enter 1 or 2: '
      choice = gets.chomp.to_i
      return choice if [1, 2].include?(choice)

      puts 'Invalid choice. Please enter 1 or 2.'
    end
  end

  def setup_game
    @available_colors = %w[red green blue yellow orange purple]
    @max_attempts = 12
    @current_attempt = 0

    if @game_mode == 1
      @secret_code = generate_secret_code
      @guesser = Player.new('player')
      puts 'Computer has created a secret code. Try to guess it!'
    else
      @secret_code = create_own_secret_code
      @guesser = Computer.new
      puts "\nComputer will try to guess your secret code!"
    end
  end

  def generate_secret_code
    Array.new(4) { @available_colors.sample }
  end

  def create_own_secret_code
    puts "\nCreate your secret code (4 colors separated by spaces)"
    puts "Available colors: #{@available_colors.join(' ')}"
    loop do
      input = gets.chomp.downcase.split
      if input.length == 4 && input.all? { |color| @available_colors.include?(color) }

        puts "secret code created! let's see if computer can guess it in #{@max_attempts} attempts"
        return input
      else
        puts 'Invalid input. Please enter exeactly 4 valid colors from the list above'
      end
    end
  end
end
