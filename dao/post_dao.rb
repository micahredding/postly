require "#{Postly::DAO_PATH}/uri_dao"
require "#{Postly::DAO_PATH}/yaml_dao"
require "#{Postly::MAPPER_PATH}/post_mapper"

class PostDao < YamlDao
  POSTS_PATH = "#{Postly::DATA_PATH}/posts"
  POSTS_PATH = "http://resources.brickcaster.com/micah/posts"

  def get_post(id)
    filename = "#{POSTS_PATH}/#{id}.yml"
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

class PostMarkdownDao < MarkdownDao
  POSTS_PATH = "#{Postly::DATA_PATH}/posts"
  POSTS_PATH = "http://resources.brickcaster.com/micah/posts"

  def get_post(id)
    filename = "#{POSTS_PATH}/#{id}.md"
    # raise Sinatra::NotFound unless File.exist?(filename)
    md = load_and_parse filename
    mapper = PostMarkdownMapper.new
    mapper.markdown_to_record id, md
  end

  def get_posts_from_list(list)
    list.collect do |id|
      get_post id
    end
  end
end