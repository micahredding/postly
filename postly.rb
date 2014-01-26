require 'sinatra'
require 'json'
require 'builder'
require 'redcarpet'
require 'nokogiri'

module BrickcasterHelpers
  class HTMLwithEmbeds < Redcarpet::Render::HTML
    def header(text, level)
      level += 1
      "<h#{level}>#{text}</h#{level}>"
    end
    def autolink(link, link_type)
      regex = /(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?(\w{10,})/
      matches = link.match(regex)
      if matches
        '<iframe width="640" height="360" src="//www.youtube.com/embed/' + matches[1] + '?rel=0" frameborder="0" allowfullscreen></iframe>'
      else
        '<a href="' + link + '">' + link + '</a>'
      end
    end
  end

  def markdown
  	@markdown ||= Redcarpet::Markdown.new(
      HTMLwithEmbeds.new(:link_attributes => Hash["target" => "_blank"]),
      :hard_wrap => true,
      :autolink => true,
      :space_after_headers => true
    )
  end
  # def format_date(date)
  #   puts DateTime.parse(date).rfc822
  #   return 0 if date.nil?
  #   DateTime.parse(date).rfc822
  # end
  # def format_date_human(date)
  #   return 0 if date.nil?
  #   Date.parse(date).strftime("%Y.%m.%d")
  # end
end

# class Schema
# 	include BrickcasterHelpers
# 	attr_accessor :hash, :json

# 	def initialize args
# 		@hash = args
# 		@json = args.to_json
#     args.each do |k,v|
#       instance_variable_set("@#{k}", v) unless v.nil?
#     end
# 	end

# 	def self.get filename
#     begin
# 	    File.open(filename, "r") do |f|
# 	      self.new JSON.load( f )
# 	    end
# 	  rescue
#       puts filename
# 	  	nil
# 	  end
# 	end

# end

# class Index < Schema
  # def self.get
  #   super 'data/index.json'
  # end
  # def podcasts
  #   @podcasts.collect do |podcast_id|
  #     Podcast.get(podcast_id)
  #   end
  # end
# end

class Stream
  include BrickcasterHelpers
	attr_accessor :stream_id

  def initialize stream_id
    @stream_id = stream_id
  end

  def filename format='json'
    'data/streams/' + @stream_id + '.' + format
  end

  def load
    begin
      File.open(filename, "r") do |f|
        JSON.load( f )
      end
    rescue
      puts @stream_id
      nil
    end
  end

  def title
    load['title']
  end

  def post_ids
    load['posts']
  end

  def posts
    post_ids.collect do |post_id|
      Post.new(post_id)
    end
  end

  def url
    '/streams/' + @stream_id
  end
end

class Post
  include BrickcasterHelpers
  attr_accessor :post_id

  def initialize post_id
    @post_id = post_id
  end

  def filename format="md"
    'data/posts/' + @post_id + '.' + format
  end

  def title
    Nokogiri::HTML(content).css('h2').text
  end

  def content
    contents = File.read(filename())
    markdown.render(contents)
  end

  def url
    '/posts/' + @post_id
  end
end

helpers BrickcasterHelpers

get '/posts/:post_id' do
	@post = Post.new(params[:post_id])
  redirect '/' if @post.nil?
	erb :post
end

# get '/:podcast_id.json' do
# 	@podcast = Podcast.get(params[:podcast_id]);
#   redirect '/' if @podcast.nil?
# 	@podcast.json
# end

get '/streams/:stream_id.rss' do
  @stream = Stream.new(params[:stream_id])
  redirect '/' if @stream.nil?
	builder :stream_rss
end

get '/streams/:stream_id' do
  @stream = Stream.new(params[:stream_id])
  redirect '/' if @stream.nil?
	erb :stream
end

# get '/' do
#   @index = Index.get
#   erb :index
# end