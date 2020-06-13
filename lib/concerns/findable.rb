module Concerns::Findable
  
  def find_by_name(name)
    all.detect{|a| a.name == name}
  end

    def find_or_create_by_name(song)
    if find_by_name(song) 
      return find_by_name(song)
    else
      song = create(song) 
      song
    end
  end

  
end

# entries( dirname ) → array
# entries( dirname, encoding: enc ) → array
# Returns an array containing all of the filenames in 
# the given directory. Will raise a SystemCallError 
# if the named directory doesn't exist.

# The optional encoding keyword argument 
# specifies the encoding of the directory. 
# If not specified, the filesystem encoding is used.