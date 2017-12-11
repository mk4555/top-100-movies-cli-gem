class Top100Movies::Movie
  attr_accessor :rank, :name, :url, :description, :rating, :genre, :directors,
  :writers, :debut, :box_office, :length, :studio

  @@all = []

  def initialize(rank=nil, name=nil, url=nil)
    @rank = rank
    @name = name
    @url = url
    @@all << self
  end


end
