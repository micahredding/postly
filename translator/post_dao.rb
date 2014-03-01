require "#{Postly::TRANSLATOR_PATH}/meta_dao"
require "#{Postly::MAPPER_PATH}/post_mapper"

class PostYamlDao < YamlDao
  def get_post(id)
    filename = "posts/#{id}.yml"
    yaml = load_and_parse filename
    mapper = PostMapper.new
    mapper.yaml_to_record id, yaml
  end
  def get_posts_from_list(list)
    list.collect do |id|
      get_post id
    end
  end
  def index
    # list = super 'posts'
    # get_posts_from_list list
    parsed_contents = load_and_parse 'posts/index.yml'
    get_posts_from_list parsed_contents['index']
  end
end

class PostMarkdownDao < MarkdownDao
  def get_post(id)
    filename = "posts/#{id}.md"
    md = load_and_parse filename
    mapper = PostMapper.new
    mapper.markdown_to_record id, md
  end
  def get_posts_from_list(list)
    list.collect do |id|
      get_post id
    end
  end
  def index
    dao = YamlDao.new
    parsed_contents = dao.load_and_parse 'posts/index.yml'
    get_posts_from_list parsed_contents['index']
    # list = super 'posts'
    # get_posts_from_list list
  end
end