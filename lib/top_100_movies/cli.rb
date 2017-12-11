class Top100Movies::CLI
  def self.call
    puts "Hellow welcome to top 100 movies!"
    puts "Data from Rotten Tomatoes"
    # doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
    # binding.pry
    Top100Movies::Scraper.scrape_movies

  end
end
