class Top100Movies::CLI
  def call
    Top100Movies::Scraper.new.generate_movies
    puts "******************************************************"
    puts "******        WELCOME TO TOP 100 MOVIES!        ******"
    puts "******************************************************"
    puts ""
    list_movies
    start
  end

  def start

    puts ""
    print "Please enter the number of the movie you'd like to know more about: "
    print "Type 'exit' to exit the program"
    input = gets.chomp
    if input.to_i > 0 && input.to_i <= 100
      movie = Top100Movies::Movie.find(input.to_i)
      Top100Movies::Movie.print_movie(movie)
      # movie.print_movie
    elsif input == "exit"
      puts "Goodbye!!"
      exit
    else
      puts "Wrong input"
      start
    end
  end

  def list_movies
    puts " Rank |      Name      | Score "
    Top100Movies::Movie.all.each do |movie|
      puts " #{movie.rank}. #{movie.name}  #{movie.rating}"
    end
  end
end
