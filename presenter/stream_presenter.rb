require "#{Postly::LIB_PATH}/markdown_compiler"

class StreamPresenter
  NAMESPACE = "/streams"
  # NAMESPACE = ""

  def self.new_list streams
    streams.collect do |stream|
      StreamPresenter.new stream
    end
  end

  def initialize(stream, posts=nil)
    @stream = stream
    @posts = posts
  end

  def id
    @stream.id
  end

  def title
    @stream.title
  end

  def subscribe
    @stream.subscribe
  end

  def path
    "#{NAMESPACE}/#{@stream.id}"
  end

  def rss_path
    "#{NAMESPACE}/#{@stream.id}.rss"
  end

  def posts
    @posts.reverse.collect do |post|
      PostPresenter.new post
    end
  end

  def twitter_status
    @stream.title
  end

end
