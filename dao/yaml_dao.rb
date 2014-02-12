require 'yaml'

class YamlDao
  def load_and_parse(filename)
    YAML.load_file(filename)
  end
end
