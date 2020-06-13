class MusicLibraryController

  def initialize(path = './db/mp3s')
   song_path = MusicImporter.new(path)
   @song_list = song_path.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
    loop_until_exit(input)
  end

  def loop_until_exit(input)
    call unless input == 'exit'
  end

  def list_songs
   alpha_song_list = Song.all.sort! { |a, b|  a.name  <=> b.name }
   alpha_song_list.each_with_index do |song, index|
    puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
   end
  end
  def list_artists
    alpha_artist_list = Artist.all.sort! { |a, b|  a.artist.name  <=> b.artist.name }
    alpha_artist_list.uniq! {|song| song.artist}
   
   binding.pry 
   
    alpha_artist_list.each_with_index do |song, index|
     puts "#{index + 1}. #{song.artist.name}"
   end
  
  end


end