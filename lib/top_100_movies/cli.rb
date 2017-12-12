class Top100Movies::CLI
  def call
    Top100Movies::Scraper.new.generate_movies
    puts "Hello welcome to top 100 movies!"
    puts "Data from Rotten Tomatoes"
    # doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
    # binding.pry
    start
  end

  def start
    list_movies
  end

  def list_movies
    puts "| Rank |      Name      | Rating |"
    Top100Movies::Movie.all.each do |movie|
      puts " #{movie.rank}. #{movie.name}  #{movie.rating}"
    end
  end
end
