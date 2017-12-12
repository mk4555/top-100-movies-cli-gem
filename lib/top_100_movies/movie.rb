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
    @@all[rank-1]
  end

  def self.print(movie)

  end
end
