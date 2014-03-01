require "#{Postly::TRANSLATOR_PATH}/meta_dao"
require "#{Postly::MAPPER_PATH}/stream_mapper"

class StreamYamlDao < YamlDao
  def get_stream(id)
    filename = "streams/#{id}.yml"
    yaml = load_and_parse filename
    mapper = StreamMapper.new
    mapper.yaml_to_record id, yaml
  end

  def get_streams_from_list(list)
    list.collect do |id|
      get_stream id
    end
  end

  def index
    parsed_contents = load_and_parse 'streams/index.yml'
    get_streams_from_list parsed_contents['index']
    # list = super 'streams'
    # get_streams_from_list list
  end
end