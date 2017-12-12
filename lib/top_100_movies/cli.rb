class Top100Movies::CLI
  def self.call
    Top100Movies::Scraper.new.generate_movies
    puts "Hellow welcome to top 100 movies!"
    puts "Data from Rotten Tomatoes"
    # doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
    # binding.pry
  end

  def list_movies
    
  end
end
