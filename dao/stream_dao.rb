require "#{Postly::DAO_PATH}/yaml_dao"
require "#{Postly::MAPPER_PATH}/stream_mapper"

class StreamDao < YamlDao
  STREAMS_PATH = "#{Postly::DATA_PATH}/streams"
  STREAMS_PATH = "http://resources.brickcaster.com/micah/streams"

  def get_stream(id)
    filename = "#{STREAMS_PATH}/#{id}.yml"
    # raise Sinatra::NotFound unless File.exist?(filename)
    yaml = load_and_parse filename
    mapper = StreamMapper.new
    mapper.yaml_to_record id, yaml
  end
end
