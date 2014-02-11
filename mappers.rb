class PostMapper
  include PostlyHelpers

	def self.filename post_id, format="md"
    'data/posts/' + post_id + '.' + format
  end

	def self.load post_id
    file_contents = File.read self.filename(post_id)
    title = Nokogiri::HTML(file_contents).css('h2').text || post_id
    Post.new(post_id, title, file_contents)
	end
end

class StreamMapper
	def self.filename stream_id, format="json"
    'data/streams/' + stream_id + '.' + format
  end

	def self.load stream_id
    begin
      File.open(self.filename(stream_id), "r") do |f|
        Stream.new(stream_id, JSON.load( f ) )
      end
    rescue
      nil
    end
	end

  def self.index
    begin
      File.open(filename('index'), "r") do |f|
        index = JSON.load( f )
        index['streams']
      end
    rescue
      nil
    end
  end
end