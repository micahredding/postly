require 'open-uri'

class MarkdownDao
  def load_and_parse(filename)
  	open(filename) do |f|
	    f.read
	  end
  end
end
