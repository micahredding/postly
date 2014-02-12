require "#{Postly.DAO_PATH}/yaml_dao"
require "#{Postly.MAPPER_PATH}/stream_mapper"

class StreamDao < YamlDao
  STREAMS_PATH = "#{Postly.DATA_PATH}/streams"

  def get_post(id)
    filename = "#{POSTS_PATH}/#{id}"
    raise Sinatra::NotFound unless File.exist?(filename)
    yaml = load_and_parse "#{POSTS_PATH}/#{id}"
    mapper = PostMapper.new
    mapper.yaml_to_record id, yaml
  end
end
