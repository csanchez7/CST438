=begin Hangman


=end

  #choose randome word from words.text
  def pick_random
   random_word = nil
    File.open("words.txt") do |file|
      file_lines = file.readlines()
      random_word = file_lines[Random.rand(0...file_lines.size())]
   end
  return random_word
  end
  
  guess = ""
  
  while guess != random_word
    puts "Enter Guess:"
    guess = gets.chomp()
  end
  
  puts "You got it!"
  