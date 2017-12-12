class Top100Movies::CLI
  def call
    Top100Movies::Scraper.new.generate_movies
    puts "******************************************************"
    puts "******        WELCOME TO TOP 100 MOVIES!        ******"
    puts "******************************************************"
    puts ""
    # start
    doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/m/the_wizard_of_oz_1939"))
    binding.pry
    # doc.search("div#movieSynopsis").first.text.strip -> Synopsis
    #
  end

  def start
    list_movies
    puts ""
    print "Please enter the number of the movie you'd like to know more about: "
    input = gets.chomp
    if input.to_i > 0 && input.to_i <= 100
      puts "correct input"
      # movie = Top100Movies::Movie.find(input.to_i)
      # Top100Movies::Movie.print_movie(movie)
    elsif input == "exit"
      puts "See you later!"
      exit
    end
  end

  def list_movies
    puts " Rank |      Name      | Score "
    Top100Movies::Movie.all.each do |movie|
      puts " #{movie.rank}. #{movie.name}  #{movie.rating}"
    end
  end
end
