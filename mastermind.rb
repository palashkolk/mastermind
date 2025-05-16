color_pegs = %w[orange blue red green yellow purple]
secret_code = []
hints_array = []
hints = []

(0..3).each { |i| secret_code[i] = color_pegs[rand(6)] }
# yellow blue purple red
p secret_code
until hints.length == 4 && hints.all?('black')
  store = Hash.new { |hash, key| hash[key] = [] }
  hints = []
  puts 'Enter your guesses in 1234 order separated by a space'
  guess_array = gets.chomp.split
  guess_array.each_index do |guess_index|
    next unless secret_code.include?(guess_array[guess_index])

    matched_code_index = secret_code.each_index.select { |i| secret_code[i] == guess_array[guess_index] }
    store[matched_code_index] = store[matched_code_index].push(guess_index)
  end
  store.each_pair do |matched_code_index, matched_guess_index|
    iter_array = matched_code_index.size <= matched_guess_index.size ? matched_code_index : matched_guess_index
    search_array = matched_code_index.size <= matched_guess_index.size ? matched_guess_index : matched_code_index
    iter_array.each do |index_value|
      search_array.include?(index_value) ? hints.push('black') : hints.push('white')
    end
  end
  p store
  p hints.shuffle
  p hints.shuffle unless hints.length == 4 && hints.all?('black')
  hints_array.push(hints.shuffle)
  if hints_array.length > 12
    p 'You loose'
    break
  end
end
p "You won! the correct code is #{secret_code}"
