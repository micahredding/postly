require "#{Postly::LIB_PATH}/markdown_compiler"
require 'nokogiri'

class PostPresenter
  NAMESPACE = Postly::POSTS_NAMESPACE

  def initialize(post)
    @post = post
  end

  def id
    @post.id
  end

  def title
    @post.title || parsed_title
  end

  def parsed_title
    @parsed_title ||= Nokogiri::HTML(content).css('h2')[0].text || id
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
    title
  end

end
