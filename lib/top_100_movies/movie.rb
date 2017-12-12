class Top100Movies::Movie
  attr_accessor :rank, :name, :score, :url, :synopsis, :rating, :genres, :directors,
  :writers, :release_date, :box_office, :runtime, :studio

  @@all = []

  def initialize(rank=nil, name=nil, score=nil, url=nil)
    @rank = rank
    @name = name
    @score = score
    @url = url
    @box_office = "N/A"
    @@all << self
  end

  def self.new_from_index(index)
    self.new(
      index.search(".bold").text.tr('\.',''),
      index.search(".unstyled").text.strip,
      index.search(".tMeterScore").text.strip,
      self.scrape_url(index)
    )
  end

  def self.scrape_url(index)
    url = "https://www.rottentomatoes.com"
    index.search("a").each do |link|
      url += link['href']
    end
    url
  end

  def self.all
    @@all.reject! { |c| c.name.empty? }
  end

  def self.find(rank)
    if @@all[rank-1].synopsis == nil
      self.scrape_details(@@all[rank-1])
      @@all[rank-1]
    else
      @@all[rank-1]
    end
  end

  def self.print_movie(movie)
    puts ""
    puts "#{movie.rank}. #{movie.name}"
    puts ""
    puts "SYNOPSIS"
    puts "#{movie.synopsis}"
    puts ""
    puts "Rating: \t#{movie.rating}"
    puts "Genre: \t\t#{movie.genres.join(", ")}"
    puts "Directors:\t#{movie.directors}"
    puts "Writers:\t#{movie.writers}"
    puts "In Theaters:\t#{movie.release_date[0..11]}"
    puts "Box Office:\t#{movie.box_office}"
    puts "Runtime: \t#{movie.runtime}"
    puts "Studio: \t#{movie.studio}"
  end

  def self.scrape_details(movie)
    doc = Nokogiri::HTML(open("#{movie.url}"))
    
    movie.synopsis = doc.search("div#movieSynopsis").first.text.strip
    details = doc.search(".meta-value").map{|i| i.text.strip}

    if details.size == 8
      genres = details[1].split(", \n")
      genres.map!{|genre| genre.gsub(/\s{2,}/,'')}
      movie.genres = genres
      details.delete(details[1])

      movie.rating = details[0]
      movie.directors = details[1]
      movie.writers = details[2]
      movie.release_date = details[3]
      movie.runtime = details[5]
      movie.studio = details[6]
    else
      genres = details[1].split(", \n")
      genres.map!{|genre| genre.gsub(/\s{2,}/,'')}
      movie.genres = genres
      details.delete(details[1]) # delete genres

      movie.rating = details[0]
      movie.directors = details[1]
      movie.writers = details[2]
      movie.release_date = details[3]
      movie.box_office = details[5]
      movie.runtime = details[6]
      movie.studio = details[7]
    end
  end

end
