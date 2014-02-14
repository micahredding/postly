require "#{Postly::MODEL_PATH}/post"

class PostMapper
  def yaml_to_record(id, yaml)
    post = Post.new(id)
    post.title = yaml['title']
    post.body = yaml['body']
    post
  end
end

