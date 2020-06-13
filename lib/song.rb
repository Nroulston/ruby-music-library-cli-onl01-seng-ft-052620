# frozen_string_literal: true

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def save
    @@all << self
  end

  def initialize(name, artist_instance = nil, genre_instance = nil)
    @name = name
    self.artist = artist_instance if artist_instance
    self.genre = genre_instance if genre_instance
    
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist_instance)
    @artist = artist_instance
    @artist.add_song(self)
    @artist
  end

  def genre=(genre_instance)
    @genre = genre_instance
    @genre.add_song(self)
    @genre
  end

  def self.new_from_filename(files)
    split_file = files.gsub(".mp3" , "").split(" - ")
    song = Song.new(split_file[1])
    artist = Artist.find_or_create_by_name(split_file[0])
    song.artist = artist
    new_genre = Genre.find_or_create_by_name(split_file[2])
    # binding.pry
    song.genre = new_genre
    song
  end

  def self.create_from_filename(files)
    song = self.new_from_filename(files)
	  song.save
  end
end
