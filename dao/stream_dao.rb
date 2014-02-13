require "#{Postly.DAO_PATH}/yaml_dao"
require "#{Postly.MAPPER_PATH}/stream_mapper"

class StreamDao < YamlDao
  STREAMS_PATH = "#{Postly.DATA_PATH}/streams"

  def get_post(id)
    filename = "#{STREAMS_PATH}/#{id}"
    raise Sinatra::NotFound unless File.exist?(filename)
    yaml = load_and_parse "#{STREAMS_PATH}/#{id}"
    mapper = StreamMapper.new
    mapper.yaml_to_record id, yaml
  end
end
