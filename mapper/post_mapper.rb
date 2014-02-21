require 'nokogiri'
require "#{Postly::MODEL_PATH}/post"
require "#{Postly::LIB_PATH}/markdown_compiler"

class PostMapper
  def yaml_to_record(id, yaml)
    post = Post.new(id)
    post.title = yaml['title']
    post.body = yaml['body']
    post
  end

  def markdown_to_record(id, md)
    post = Post.new(id)
    post.title = md.lines.first.chomp.delete('#').strip || id
    post.body = md
    post
  end

  def row_to_record(id, row)
    post = Post.new(id)
    post.title = row[1]
    post.body = row[2]
    post
  end
end