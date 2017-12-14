class Top100Movies::Scraper

  def get_page
    Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
  end

  def scrape_movies
    table = self.get_page.at('.table')
    cells = []
    table.search('tr').each do |tr|
      cells << tr.search('th, td')
    end
    cells
  end

  def generate_movies
    scrape_movies.each do |cell|
      Top100Movies::Movie.new_from_index(cell)
    end
  end

  def self.scrape_url(index)
    url = "https://www.rottentomatoes.com"
    index.search("a").each do |link|
      url += link['href']
    end
    url
  end

  def self.scrape_details(movie)
    doc = Nokogiri::HTML(open("#{movie.url}"))

    movie.synopsis = doc.search("div#movieSynopsis").first.text.strip
    
    labels = doc.search(".meta-label").map{|i| i.text.strip}
    values = doc.search(".meta-value").map{|i| i.text.strip}

    labels.each_index do |i|
      case labels[i]
      when "Rating:"
        movie.rating = values[i]
      when "Genre:"
        genres = values[i].split(", \n")
        # binding.pry
        genres.map!{|genre| genre.gsub(/\s{2,}/,'')}
        movie.genres = genres
      when "Directed By:"
        movie.directors = values[i]
      when "Written By:"
        movie.writers = values[i]
      when "In Theaters:"
        movie.release_date = values[i][0..11]
      when "On Disc/Streaming"
        movie.disc_release_date = values[i]
      when "Box Office:"
        movie.box_office = values[i]
      when "Runtime:"
        movie.runtime = values[i]
      when "Studio:"
        movie.studio = values[i]
      end
    end

    # if details.size == 8
    #   genres = details[1].split(", \n")
    #   genres.map!{|genre| genre.gsub(/\s{2,}/,'')}
    #   movie.genres = genres
    #   details.delete(details[1])
    #
    #   movie.rating = details[0]
    #   movie.directors = details[1]
    #   movie.writers = details[2]
    #   movie.release_date = details[3]
    #   movie.runtime = details[5]
    #   movie.studio = details[6]
    # else
    #   genres = details[1].split(", \n")
    #   genres.map!{|genre| genre.gsub(/\s{2,}/,'')}
    #   movie.genres = genres
    #   details.delete(details[1]) # delete genres
    #
    #   movie.rating = details[0]
    #   movie.directors = details[1]
    #   movie.writers = details[2]
    #   movie.release_date = details[3]
    #   movie.box_office = details[5]
    #   movie.runtime = details[6]
    #   movie.studio = details[7]
    # end
  end

end
