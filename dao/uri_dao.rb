require 'open-uri'

class TextDao
  def load_and_parse(filename)
  	open(filename) do |f|
	    f
	  end
  end
end
