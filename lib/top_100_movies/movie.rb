class Top100Movies::Movie
  attr_accessor :rank, :name, :score, :url, :synopsis, :rating, :genre, :directors,
  :writers, :release_date, :box_office, :runtime, :studio

  @@all = []

  def initialize(rank=nil, name=nil, score=nil, url=nil)
    @rank = rank
    @name = name
    @score = score
    @url = url
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
    self.scrape_details(@@all[rank-1])
    @@all[rank-1]
  end

  def self.print_movie(movie)
    puts ""
    puts "#{movie.rank}. #{movie.name}"
    puts ""
    puts "SYNOPSIS"
    puts "#{movie.synopsis}"
    puts ""
    puts "Directors:\t#{movie.directors}"
    puts "Writers:\t#{movie.writers}"
    puts "Release Date:\t#{movie.release_date}"
    puts "Box Office:\t#{movie.box_office}"
    puts ""
  end

  def self.scrape_details(movie)
    doc = Nokogiri::HTML(open("#{movie.url}"))
    movie.synopsis = doc.search("div#movieSynopsis").first.text.strip
    arr = doc.search(".meta-value").map{|i| i.text.strip}
    arr.delete(arr[1]) # delete genres
    movie.rating = arr[0]
    movie.directors = arr[1]
    movie.writers = arr[2]
    movie.release_date = arr[3]
    movie.box_office = arr[5]
    movie.runtime = arr[6]
  end


end
