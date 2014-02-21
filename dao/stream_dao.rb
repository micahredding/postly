require "#{Postly::DAO_PATH}/meta_dao"
require "#{Postly::MAPPER_PATH}/stream_mapper"

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

  def index
    streams = super 'streams'
    mapper = StreamMapper.new
    streams.collect do |row|
      mapper.row_to_record row[0], row
    end
  end

end
