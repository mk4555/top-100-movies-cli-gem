class Top100Movies::Movie
  attr_accessor :name, :url, :description, :rating, :genre, :directors,
  :writers, :debut, :box_office, :length, :studio

  @@all = []

  def initialize(name=nil, url=nil)
    @name = name
    @url = url
    @@all << self
  end


end
