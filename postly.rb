require 'sinatra'
require 'json'
require 'builder'
require 'redcarpet'

module BrickcasterHelpers
  def markdown
  	@markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:link_attributes => Hash["target" => "_blank"]),
      :hard_wrap => true,
      :autolink => true,
      :space_after_headers => true
    )
  end
  def format_date(date)
    puts DateTime.parse(date).rfc822
    return 0 if date.nil?
    DateTime.parse(date).rfc822
  end
  def format_date_human(date)
    return 0 if date.nil?
    Date.parse(date).strftime("%Y.%m.%d")
  end
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

# class Podcast < Schema
	# attr_accessor :title, :podcast_id, :author, :url, :itunes_url, :rss_url, :keywords, :categories, :description, :links
 #  def self.get id
 #    super 'data/podcasts/' + id + '.json'
 #  end
 #  def episodes
 #    @episodes.collect! do |episode_number|
 #      Episode.get(@podcast_id, episode_number)
 #    end
 #  end
# end

class Post
  include BrickcasterHelpers
  attr_accessor :post_id

  def initialize post_id
    @post_id = post_id
  end

  def self.filename post_id, format="md"
    'data/posts/' + post_id + '.' + format
  end

  def self.get post_id
    begin
      File.open(self.filename(post_id), "r") do |f|
        self.new JSON.load( f )
      end
    rescue
      puts post_id
      nil
    end
  end

  def content
    markdown.render(File.read(self.filename(@post_id)))
  end
end

helpers BrickcasterHelpers

get '/:post_id' do
	@post = Post.get(params[:post_id])
  redirect '/' if @post.nil?
	erb :post
end

# get '/:podcast_id.json' do
# 	@podcast = Podcast.get(params[:podcast_id]);
#   redirect '/' if @podcast.nil?
# 	@podcast.json
# end

# get '/:podcast_id.rss' do
# 	@podcast = Podcast.get(params[:podcast_id]);
#   redirect '/' if @podcast.nil?
# 	builder :podcast_rss
# end

# get '/:podcast_id' do
# 	@podcast = Podcast.get(params[:podcast_id]);
#   redirect '/' if @podcast.nil?
# 	erb :podcast
# end

# get '/' do
#   @index = Index.get
#   erb :index
# end