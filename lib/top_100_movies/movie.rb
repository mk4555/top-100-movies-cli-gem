class Top100Movies::Movie
  attr_accessor :rank, :name, :score, :url, :synopsis, :rating, :genres, :directors,
  :writers, :release_date, :disc_release_date, :box_office, :runtime, :studio

  @@all = []

  def initialize(rank=nil, name=nil, score=nil, url=nil)
    @rank = rank
    @name = name
    @score = score
    @url = url
    @disc_release_date = "N/A"
    @box_office = "N/A"
    @writers = "N/A"
    @@all << self
  end

  def self.new_from_index(index)
    self.new(
      index.search(".bold").text.tr('\.',''),
      index.search(".unstyled").text.strip,
      index.search(".tMeterScore").text.strip,
      Top100Movies::Scraper.scrape_url(index)
    )
  end

  def self.all
    @@all.reject! { |c| c.name.empty? }
  end

  def self.find(rank)
    if @@all[rank-1].synopsis == nil
      Top100Movies::Scraper.scrape_details(@@all[rank-1])
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
    puts "On Disc/Streaming: \t#{movie.disc_release_date}"
    puts "Box Office:\t#{movie.box_office}"
    puts "Runtime: \t#{movie.runtime}"
    puts "Studio: \t#{movie.studio}"
    puts "RT Score: \t#{movie.score}"
  end



end
