require "#{Postly::LIB_PATH}/markdown_compiler"

class PostPresenter
  NAMESPACE = "/posts"

  def initialize(post)
    @post = post
  end

  def id
    @post.id
  end

  def title
    @post.title
  end

  def content
    @content ||= markdown_compiler.compile(@post.body)
  end

  def path
    "#{NAMESPACE}/#{@post.id}"
  end

  def markdown_compiler
    @markdown_compiler ||= MarkdownCompiler.new()
  end

  def twitter_status
    @post.title
  end

end
