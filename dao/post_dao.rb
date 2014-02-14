require "#{Postly::DAO_PATH}/yaml_dao"
require "#{Postly::MAPPER_PATH}/post_mapper"

class PostDao < YamlDao
  POSTS_PATH = "#{Postly::DATA_PATH}/posts"

  def get_post(id)
    filename = "http://stream.micahredding.com/#{id}.yml"
    puts filename
    # raise Sinatra::NotFound unless File.exist?(filename)
    yaml = load_and_parse filename
    mapper = PostMapper.new
    mapper.yaml_to_record id, yaml
  end

  def get_posts_from_list(list)
  	list.collect do |id|
  		get_post id
  	end
  end
end
