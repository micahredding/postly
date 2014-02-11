class PostController
	def self.filename post_id, format="md"
    'data/posts/' + post_id + '.' + format
  end

  def self.load post_id
    file_contents = File.read filename(post_id)
    Post.new(post_id, file_contents)
  end

  def self.url_for(post_id)
  	'posts/' + post_id
  end
end

class StreamController
	def self.filename stream_id, format="json"
    'data/streams/' + stream_id + '.' + format
  end

  def self.load stream_id
    begin
      File.open(filename(stream_id), "r") do |f|
        Stream.new(stream_id, JSON.load( f ) )
      end
    rescue
      nil
    end
  end

  def self.load_all stream_ids
    stream_ids.collect do |stream_id|
      self.load stream_id
    end
  end

  def self.url_for(stream_id)
  	stream_id
  end

  def self.rss_url_for(stream_id)
  	stream_id + '.rss'
  end

  def self.index
    begin
      File.open(filename('index'), "r") do |f|
        index = JSON.load( f )
        streams = index['streams']
        self.load_all(streams)
      end
    rescue
      nil
    end
  end
end