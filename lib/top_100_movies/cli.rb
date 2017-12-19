class Top100Movies::CLI
  def call
    Top100Movies::Scraper.new.generate_movies
    start
  end

  def start
    puts "******************************************************"
    puts "******        WELCOME TO TOP 100 MOVIES!        ******"
    puts "******************************************************"
    puts ""
    puts "Please enter how many movies you'd like to see (1-100)"
    puts ""
    input = gets.chomp

    if input.to_i.between?(1,100)
      list_movies(input.to_i)
      puts ""
      puts "Type 'exit' to exit the program"
      puts "Please enter the number of the movie you'd like to know more about"
      puts ""
      number = gets.chomp
      if number.to_i.between?(1,input.to_i)
        movie = Top100Movies::Movie.find(number.to_i)
        print_movie(movie)
        print "Would you like to checkout another movie? (y/n): "
        repeat = gets.chomp
        if repeat.downcase == 'y'
          start
        else
          puts "Goodbye!"
          exit
        end
      elsif input == "exit"
        puts "Goodbye!!"
        exit
      else
        puts "Wrong input"
        start
      end
    else
      puts "Wrong input, please put a valid number"
      call
    end
  end

  def print_movie(movie)

    puts ""
    puts "#{movie.rank}. #{movie.name}"
    puts ""
    puts "Rotten Tomatoes Score: #{movie.score}"
    puts ""
    puts "Synopsis"
    puts "#{movie.synopsis}"
    puts ""

    printf "%18s %-2s \n", "Rating:", movie.rating
    printf "%18s %-2s \n", "Genre:", movie.genres.join(", ")
    printf "%18s %-2s \n", "Directors:", movie.directors
    printf "%18s %-2s \n", "Writers:", movie.writers
    printf "%18s %-2s \n", "In Theaters:", movie.release_date[0..11]
    printf "%18s %-2s \n", "On Disc/Streaming:", movie.disc_release_date
    printf "%18s %-2s \n", "Box Office:", movie.box_office
    printf "%18s %-2s \n", "Runtime:", movie.runtime
    printf "%18s %-2s \n", "Studio:", movie.studio
  end

  def list_movies(input)

    Top100Movies::Movie.all.first(input).each do |movie|
      printf "%4s %-2s \n", "#{movie.rank}.", movie.name
    end
  end
end
