class Post
  include PostlyHelpers
  attr_accessor :post_id, :title, :content

  def initialize post_id, post_title, post_content=''
    @post_id = post_id
    @title = post_title
    @content = post_content
  end

  def content
    @markdown_content ||= markdown.render(@content)
  end
end