class Top100Movies::CLI
  def call
    Top100Movies::Scraper.new.generate_movies
    start
  end

  def start
    puts "******************************************************"
    puts "******        WELCOME TO TOP 100 MOVIES!        ******"
    puts "******************************************************"
    list_movies
    puts ""
    puts ""
    puts "Type 'exit' to exit the program"
    puts "Please enter the number of the movie you'd like to know more about"
    puts ""
    input = gets.chomp
    if input.to_i > 0 && input.to_i <= 100 #between
      movie = Top100Movies::Movie.find(input.to_i)
      Top100Movies::Movie.print_movie(movie)
      puts ""
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
  end

  def list_movies
    Top100Movies::Movie.all.each do |movie|
      printf "%4s %-2s \n", "#{movie.rank}.", movie.name
    end
  end
end
