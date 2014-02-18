require 'sqlite3'

class SQLInterface
  def initialize
    connect_to_database
  end

  def connect_to_database
    @db = SQLite3::Database.new "postly.db"
  end

  def setup_database
    delete = @db.execute("drop table if exists posts;")
    delete = @db.execute("drop table if exists streams;")
    rows = @db.execute("create table posts (id varchar(30), title varchar(30), body text);")
    rows = @db.execute("create table streams (id varchar(30), title varchar(30), subscribe varchar(255), posts text);")
  end
end

class StreamSQLInterface < SQLInterface

  def import_to_database(streams)
    streams.each do |stream|
      stream_row = [stream.id, stream.title, stream.subscribe, stream.post_ids.join(",")]
      @db.execute("INSERT INTO streams VALUES (:id, :title, :subscribe, :posts)", stream_row)
    end
  end
end

class PostSQLInterface < SQLInterface
  def import_to_database(posts)
    posts.each do |post|
      @db.execute("INSERT INTO posts VALUES (:id, :title, :body)", [post.id, post.title, post.body])
    end
  end
end