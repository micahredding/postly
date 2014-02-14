require 'yaml'
require 'open-uri'
require "#{Postly::DAO_PATH}/uri_dao"

class YamlDao
  def load_and_parse(filename)
  	open(filename) do |f|
	    YAML.load(f)
	  end
  end
end
