require "#{Postly::DAO_PATH}/meta_dao"
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
end

class StreamSQLDao < SQLDao
  def get_stream(id)
    row = load_and_parse id, 'streams'
    raise Sinatra::NotFound unless row.respond_to?(:to_ary)
    mapper = StreamMapper.new
    mapper.row_to_record id, row
  end

  def get_streams_from_list(list)
    list.collect do |id|
      get_stream id
    end
  end
end
