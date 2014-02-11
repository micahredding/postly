class PostController
  def self.load post_id
    PostMapper.load post_id
  end

  def self.url_for(post_id)
  	'posts/' + post_id
  end
end

class StreamController
  def self.load stream_id
    StreamMapper.load stream_id
  end

  def self.load_all stream_ids
    stream_ids.collect do |stream_id|
      self.load stream_id
    end
  end

  def self.index
    stream_ids = StreamMapper.index
    return nil if stream_ids.nil?
    self.load_all(stream_ids)
  end

  def self.url_for(stream_id)
  	stream_id
  end

  def self.rss_url_for(stream_id)
  	stream_id + '.rss'
  end
end