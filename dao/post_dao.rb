require "#{Postly::DAO_PATH}/meta_dao"
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
end

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
end