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
    input_check(input)
    loop_until_exit(input)
  end
  def input_check(input)
    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
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
    alpha_artist_list = Artist.all.sort! { |a, b|  a.name  <=> b.name }
    alpha_artist_list.uniq! {|artist| artist.name}
    alpha_artist_list.each_with_index do |artist, index|
     puts "#{index + 1}. #{artist.name}"
   end
  end

  def list_genres
    alpha_genre_list = Genre.all.sort! { |a, b|  a.name  <=> b.name }
    alpha_genre_list.uniq! {|genre| genre.name}
    alpha_genre_list.each_with_index do |genre, index|
     puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp

    artist_songs = Song.all.select {|song| song.artist.name == input}
    sorted_songs = artist_songs.sort! { |a, b|  a.name  <=> b.name }
    sorted_songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
     end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp

    songs = Song.all.select {|song| song.genre.name == input}
    sorted_songs = songs.sort! { |a, b|  a.name  <=> b.name }
    sorted_songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"
     end
  end

  def play_song

    puts "Which song number would you like to play?"
    Song.all.sort! { |a, b|  a.name  <=> b.name }
    input = gets.chomp.to_i
    all = Song.all
    if input <= all.count && input > 0
      puts "Playing #{all[input - 1].name} by #{all[input - 1].artist.name}"

   end
  end

end