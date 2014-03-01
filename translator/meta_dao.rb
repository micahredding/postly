require 'open-uri'
require 'yaml'
require "#{Postly::MAPPER_PATH}/post_mapper"

# class LocalDao
#   def prefix
#     Postly::DATA_PATH
#   end
#   def load(filename)
#     filename = "#{prefix}/#{filename}"
#     raise Sinatra::NotFound unless File.exist?(filename)
#     File.read(filename)
#   end
#   def index(directory, format)
#     files = "#{prefix}/#{directory}/*.#{format}"
#     Dir.glob(files)
#   end
# end

class RemoteDao
  def prefix
    Postly::REMOTE_DATA_PATH
  end
  def load(filename)
    filename = "#{prefix}/#{filename}"
    begin
      open(filename) do |f|
        f.read
      end
    rescue
      raise Sinatra::NotFound
    end
  end
  def index(directory, format)
    files = "#{prefix}/#{directory}/*.#{format}"
    Dir.glob(files)
  end
end

class YamlDao < RemoteDao
  def load_and_parse(filename)
    f = load filename
    YAML.load(f)
  end
  def index(directory)
    super directory, 'yml'
  end
end

class MarkdownDao < RemoteDao
  def load_and_parse(filename)
    load filename
  end
  def index(directory)
    super directory, 'md'
  end
end

