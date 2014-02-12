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