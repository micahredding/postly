class Post
  include PostlyHelpers
  attr_accessor :post_id, :title, :content

  def initialize post_id, post_content=''
    @post_id = post_id
    @content = post_content
  end

  def title
    Nokogiri::HTML(content).css('h2').text
  end

  def content
    @markdown_content ||= markdown.render(@content)
  end
end