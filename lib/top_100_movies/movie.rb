class Top100Movies::Movie
  attr_accessor :rank, :name, :url, :description, :rating, :genre, :directors,
  :writers, :debut, :box_office, :length, :studio

  @@all = []


  # cells.each do |cell|
  #   puts "#{cell.search(".bold").text.strip}"
  #   puts "#{cell.search(".tMeterScore").text.strip}" # Extracts RT scores
  #   puts "#{cell.search(".unstyled").text.strip}" # Extracts Movie Name
  #   cell.search("a").each {|link| puts "#{link['href']}"} # Extracts URL
  # end
  def self.new_from_index(index)
    self.new(
      index.search(".bold").text.strip,
      index.search(".unstyled").text.strip,
      index.search("a").each{|link| link['href']}
    )
    puts "#{index.search(".bold").text.strip}"
    puts "#{index.search(".unstyled").text.strip}"
  end

  def initialize(rank=nil, name=nil, url=nil)
    @rank = rank
    @name = name
    @url = url
    @@all << self
  end




end
