class Stream
  include PostlyHelpers
	attr_accessor :stream_id, :title, :post_ids, :subscribe

  def initialize stream_id, stream_hash
    @stream_id = stream_id
    @title = stream_hash['title']
    @post_ids = stream_hash['posts']
    @subscribe  = stream_hash['subscribe']
  end

  def posts
    @post_ids.collect do |post_id|
      PostController.load(post_id)
    end
  end
end
