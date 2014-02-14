require 'yaml'
require 'open-uri'

class YamlDao
  def load_and_parse(filename)
  	open(filename) do |f|
	    YAML.load(f)
	  end
  end
end
