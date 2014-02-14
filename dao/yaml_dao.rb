require 'yaml'
require 'open-uri'
require "#{Postly::DAO_PATH}/uri_dao"

class YamlDao < UriDao
  def load_and_parse(filename)
    f = super filename
    YAML.load(f)
  end
end
