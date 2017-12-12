class Top100Movies::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
  end

  def scrape_movies
    table = self.get_page.at('.table')
    cells = []
    table.search('tr').each do |tr|
      cells << tr.search('th, td')
      # puts "#{tr.search('th, td')}"
    end
    cells
  end

  def generate_movies
    scrape_movies.each do |cell|
      Top100Movies::Movie.new_from_index(cell)
    end
  end

end
