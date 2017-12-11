class Top100Movies::Scraper

  def self.get_page
    Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
  end

  def self.scrape_movies
    table = self.get_page.at('.table')
    cells = []
    table.search('tr').each do |tr|
      cells << tr.search('th, td')
      # puts "#{tr.search('th, td')}"
    end

    cells.each do |cell|
      puts "#{cell.search(".tMeterScore").text.strip}" # Extracts RT scores
      puts "#{cell.search(".unstyled").text.strip}"
    end
  end

end
