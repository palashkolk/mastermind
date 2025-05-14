color_pegs = %w[orange blue red green yellow purple]
hint_pegs = []
hints = []
secret_code = []

(0..3).each { |i| secret_code[i] = color_pegs[rand(6)] }
# secret_code_copy = secret_code

until hints.length == 4 && hints.all?('red')
  puts 'Enter your guesses in 1234 order separated by a space'
  guess_array = gets.chomp.split
  p guess_array
  guess_array.each_with_index do |guess, idx|
    next unless secret_code.include?(guess)

    guess == secret_code[idx] ? hints.push('black') : hints.push('white')
    # secret_code_copy.shift
  end
  hint_pegs.push(hints.shuffle)
  hints = []

  p hint_pegs
  p secret_code
  # p secret_code_copy

end
