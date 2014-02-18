require 'open-uri'
require 'yaml'
require 'sqlite3'
require "#{Postly::DAO_PATH}/sql_interface"
require "#{Postly::MAPPER_PATH}/post_mapper"

class LocalDao
  def prefix
    Postly::DATA_PATH
  end
  def load(filename)
    filename = "#{prefix}/#{filename}"
    raise Sinatra::NotFound unless File.exist?(filename)
    File.read(filename)
  end
end

class RemoteDao
  def prefix
    "http://resources.brickcaster.com/micah"
  end
  def load(filename)
    filename = "#{prefix}/#{filename}"
    open(filename) do |f|
      f.read
    end
  end
end

class SQLDao < SQLInterface
  def initialize
    connect_to_database
  end
  def load_and_parse(id, table)
    @db.execute("select * from #{table} where id = ?", id) do |row|
      return row
    end
  end
end

class YamlDao < RemoteDao
  def load_and_parse(filename)
    f = load filename
    YAML.load(f)
  end
end

class MarkdownDao < RemoteDao
  def load_and_parse(filename)
    load filename
  end
end

