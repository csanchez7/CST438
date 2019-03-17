  class Hangman

    def initialize()
      @wrong_guess_limit = 4
      @wrong_guess_count = 0
      @attempted_guesses = ""
      @secret_word = secret_word().chomp
      @secret_word_chars = @secret_word.chars
      @underscored_secret = underscores
    end
    
    #checks to see if letter is in word
    def letter_in_word(guess)
      @secret_word.include?(guess) ? true : false
    end
    
    #choose randome word from words.text
    def secret_word
     random_word = nil
      File.open("words.txt") do |file|
        file_lines = file.readlines()
        random_word = file_lines[Random.rand(0...file_lines.size())]
     end
     return random_word
    end
      
    #creates an hidden letters version of the secret word
    def underscores
      @underscored_secret = @secret_word.gsub(/\w/, "_")
    end
    
    #reveals guess letter in underscored version of the word
    def reveal(guess)
      @underscored_secret.split(" ").join("")
      @secret_word.split("").each_with_index do |letter, index|
        guess == letter ? @underscored_secret[index] = guess : ""
      end
      @underscored_secret.split("").join(" ")
    end 
    
    #asks user for guess
    def guess()
        puts "Guess a letter: "
        @user_input = [gets.chomp.downcase]
        [@user_input].any?(/[a-z]/) ? (puts "Only letters please."; guess()) : ""
        @user_input[0]
    end
    
    #checks if letters are in secret word
    def any_letters?(guess)
		  @secret_word.include?(guess) ? true : false
	  end
    
    #correct guess - reveals letter
    def correct_guess(guess)
      reveal(guess)
    end
    
    #incorrect guess - adds to wrong guess count
    def incorrect_guess(guess)
      @wrong_guess_count += 1
    end
    
    #checks to see if letter is included in attempted guesses
    #if not, adds it
    def guessed_letters(guess = "")
      @attempted_guesses.include?(guess) ? "" : @attempted_guesses += guess
    end

    #guessed letters
    def past_letters
      @attempted_guesses
    end
    
    #win message
    def win
      puts "", "You win!"
    end
    
    #lose message
    def lose
      puts "", "You lose. You are out of guesses.", "The word was #{@secret_word}."
    end
    
    #prints guessed letters and underscored word
    def display
  		puts "#{@body}\n\n Guessed letters: #{past_letters.split("").join("-")}\n Correct letters so far: #{@underscored_secret.split("").join(" ")}"
    end
    
    #starts the game while game_over?
    def start
      until game_over?
        play
      end
    end 
    
    #scenario for game over
    def game_over?
      if @wrong_guess_count >= 4
        lose()
        return true
      elsif (!@underscored_secret.include?("_"))
        win()
        return true
      end
      false
    end
    
    #plays out the game sequence after guess
    def play()
      player_guess = guess
      if (!past_letters.include?(player_guess) && player_guess.length == 1)
        guessed_letters(player_guess)
        any_letters?(player_guess) ? correct_guess(player_guess) : incorrect_guess(player_guess)
        display
      elsif (player_guess.length>1)
        puts "You must guess 1 letter at a time."
      end
    end
    
    #hangman 
    def hangman()
     
      puts "Welcome to hangman!", "Try to guess the word by guessing one letter at a time.", " "
      puts "The word is: " + @secret_word, " "
      start
    end
  
  end  #end of class
  
  game = Hangman.new
  game.hangman()