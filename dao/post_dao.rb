require "#{Postly.DAO_PATH}/yaml_dao"
require "#{Postly.MAPPER_PATH}/post_mapper"

class PostDao < YamlDao
  POSTS_PATH = "#{Postly.DATA_PATH}/posts"

  def get_post(id)
    filename = "#{POSTS_PATH}/#{id}"
    raise Sinatra::NotFound unless File.exist?(filename)
    yaml = load_and_parse "#{POSTS_PATH}/#{id}"
    mapper = PostMapper.new
    mapper.yaml_to_record id, yaml
  end
end
