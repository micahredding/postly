require "#{Postly::DAO_PATH}/meta_dao"
require "#{Postly::MAPPER_PATH}/post_mapper"

class PostSQLDao < SQLDao

  def get_post(id)
    row = load_and_parse id, 'posts'
    raise Sinatra::NotFound unless row.respond_to?(:to_ary)
    mapper = PostMapper.new
    mapper.row_to_record id, row
  end

  def get_posts_from_list(list)
    list.collect do |id|
      get_post id
    end
  end

  def index
    posts = super 'posts'
    mapper = PostMapper.new
    posts.collect do |row|
      mapper.row_to_record row[0], row
    end
  end

end
