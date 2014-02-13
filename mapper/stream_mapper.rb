require "#{Postly.MODEL_PATH}/stream"

class StreamMapper
  def yaml_to_record(id, yaml)
    stream = Stream.new(id)
    stream.title = yaml['title']
    stream.subscribe = yaml['subscribe']
    stream.post_ids = yaml['posts']
    stream
  end
end

