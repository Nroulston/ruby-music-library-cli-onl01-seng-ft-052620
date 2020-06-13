class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  
  def save 
    @@all << self
  end
  
  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
 
  def songs
    @songs
  end

  def add_song(song)
    song.genre = self unless song.genre
    @songs << song unless @songs.include?(song)
  end

  def artists
    songs.collect {|songs| songs.artist}.uniq
  end

  
end