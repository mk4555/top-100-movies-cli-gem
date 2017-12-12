class Top100Movies::Movie
  attr_accessor :rank, :name, :url, :description, :rating, :genre, :directors,
  :writers, :debut, :box_office, :length, :studio

  @@all = []

  def initialize(rank=nil, name=nil, rating=nil, url=nil)
    @rank = rank
    @name = name
    @rating = rating
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



end
