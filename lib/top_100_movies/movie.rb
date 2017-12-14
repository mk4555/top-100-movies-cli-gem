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
    @@all.reject { |c| c.name.empty? }
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
    puts "Rotten Tomatoes Score: #{movie.score}"
    puts ""
    puts "Synopsis"
    puts "#{movie.synopsis}"
    puts ""

    printf "%18s %-2s \n", "Rating:", movie.rating
    printf "%18s %-2s \n", "Genre:", movie.genres.join(", ")
    printf "%18s %-2s \n", "Directors:", movie.directors
    printf "%18s %-2s \n", "Writers:", movie.writers
    printf "%18s %-2s \n", "In Theaters:", movie.release_date[0..11]
    printf "%18s %-2s \n", "On Disc/Streaming:", movie.disc_release_date
    printf "%18s %-2s \n", "Box Office:", movie.box_office
    printf "%18s %-2s \n", "Runtime:", movie.runtime
    printf "%18s %-2s \n", "Studio:", movie.studio
  end



end
