require_relative 'computer'
require_relative 'player'

class Game
  attr_reader :code_breaker_name

  def initialize
    puts 'Welcome to the Game!'
    @game_mode = get_game_mode
    print 'Please enter name of the code breaker: '
    @code_breaker_name = gets.chomp
    set_up_game
  end

  def play
    puts "\nGame is starting"
    puts "Player has maximum #{@max_attempt} attempts\n"

    loop do
      @guess_code = @guesser.make_guess
      result = make_guess(@guess_code)
      if result.is_a?(String)
        puts result
        break
      else
        puts "feedback: #{result[:black]} black pegs, #{result[:white]} white pegs"
        puts 'Black: Correct color, correct position; White: Correct color, wrong position.'
      end
    end
  end

  private

  def make_guess(player_guess)
    @current_attempt += 1
    if @current_attempt > @max_attempt
      "game over! #{@guesser.name} looses the match. The code is #{@secret_code}."
    elsif @guess_code == @secret_code
      "Congrats! #{@guesser.name} wins in #{@current_attempt} attempts!"
    else
      generate_feedback(player_guess)
    end
  end

  def generate_feedback(player_guess)
    black_pegs = 0
    total_color_match = 0

    @guess_code.each_with_index do |color, index|
      black_pegs += 1 if color == @secret_code[index]
    end

    @guess_code.uniq.each do |color|
      guess_count = @guess_code.count(color)
      secret_count = @secret_code.count(color)
      total_color_match += [guess_count, secret_count].min
    end
    white_pegs = total_color_match - black_pegs
    puts "\n#{@code_breaker_name} guesses #{@guess_code}" if @game_mode == 2

    { black: black_pegs, white: white_pegs }
  end

  def set_up_game
    @current_attempt = 0
    @max_attempt = 12
    @available_colors = %w[red blue green orange yellow purple]
    if @game_mode == 1
      puts 'Computer has created a secret code of 4 colors. Try to guess it!'
      @guesser = Player.new(@code_breaker_name)
      @secret_code = generate_secret_code
    else
      @guesser = Computer.new(@code_breaker_name)
      @secret_code = create_own_code

    end
  end

  def generate_secret_code
    Array.new(4) { @available_colors.sample }
  end

  def create_own_code
    puts 'Please enter 4 color separated by space from below selection to make your secret code!'
    puts "Available colors: #{@available_colors.join(' ')}"
    loop do
      secret_code = gets.chomp.downcase.split(' ')
      puts 'Thank you for creating the code. Computer will now try to break it!'
      return secret_code if secret_code.all? { |color| @available_colors.include?(color) }

      puts 'Invalid choice! Please enter exeactly 4 colors from above'
    end
  end

  def get_game_mode
    puts 'Choose how you want to play:'
    puts '1. Computer generates code and you break it!'
    puts '2. You make code and computer guesses it'
    loop do
      input = gets.chomp.to_i
      return input if [1, 2].include?(input)

      puts 'Invalid input! Please eneter 1 or 2 for the above options.'
    end
  end
end
