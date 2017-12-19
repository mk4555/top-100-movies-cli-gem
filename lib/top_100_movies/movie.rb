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
  
end
