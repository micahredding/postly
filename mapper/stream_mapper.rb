require "#{Postly::MODEL_PATH}/stream"

class StreamMapper
  def yaml_to_record(id, yaml)
    stream = Stream.new(id)
    stream.title = yaml['title']
    stream.subscribe = yaml['subscribe']
    stream.post_ids = yaml['posts']
    stream
  end

  def row_to_record(id, row)
    stream = Stream.new(id)
    stream.title = row[1]
    stream.subscribe = row[2]
    stream.post_ids = row[3].split(",")
    stream
  end
end

