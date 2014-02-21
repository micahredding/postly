require 'open-uri'
require 'yaml'
require 'sqlite3'
require "#{Postly::MAPPER_PATH}/post_mapper"

class SQLDao

  def initialize
    connect_to_database
  end

  def connect_to_database
    @db = SQLite3::Database.new "postly.db"
  end

  def index(table)
    rows = []
    @db.execute("select * from #{table}") do |row|
      rows << row
    end
    rows
  end

  def setup_database
    delete = @db.execute("drop table if exists posts;")
    delete = @db.execute("drop table if exists streams;")
    rows = @db.execute("create table posts (id varchar(30), title varchar(30), body text);")
    rows = @db.execute("create table streams (id varchar(30), title varchar(30), subscribe varchar(255), posts text);")
  end

  def load_and_parse(id, table)
    @db.execute("select * from #{table} where id = ?", id) do |row|
      return row
    end
  end

end

class StreamSQLInterface < SQLDao
  def import_row(stream)
    stream_row = [stream.id, stream.title, stream.subscribe, stream.post_ids.join(",")]
    @db.execute("INSERT INTO streams VALUES (:id, :title, :subscribe, :posts)", stream_row)
  end
  def import_to_database(streams)
    streams.each do |stream|
      import_row stream
    end
  end
end

class PostSQLInterface < SQLDao
  def import_row(post)
    @db.execute("INSERT INTO posts VALUES (:id, :title, :body)", [post.id, post.title, post.body])
  end
  def import_to_database(posts)
    posts.each do |post|
      import_row post
    end
  end
end