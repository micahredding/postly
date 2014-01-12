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
  def format_length(length)
    if length.nil?
      return "00:00:00"
    end
    length = Time.at(length.to_i).utc.strftime("%H:%M:%S")
  end
  def format_date(date)
    return 0 if date.nil?
    Date.parse(date).rfc822
  end
  def format_date_human(date)
    return 0 if date.nil?
    Date.parse(date).strftime("%Y.%m.%d")
  end
end

class Schema
	include BrickcasterHelpers
	attr_accessor :hash, :json

	def initialize args
		@hash = args
		@json = args.to_json
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
	end

	def self.filename(id)
		'data/' + id + '.json'
	end

	def self.get id
    begin
	    File.open(self.filename(id), "r") do |f|
	      self.new JSON.load( f )
	    end
	  rescue
	  	nil
	  end
	end

end

class Index < Schema
  def self.get
    super 'index'
  end
  def podcasts
    @podcasts.collect! do |podcast_id|
      Podcast.get(podcast_id)
    end
  end
end

class Podcast < Schema
	attr_accessor :title, :podcast_id, :author, :url, :itunes_url, :rss_url, :keywords, :categories, :description, :links
	def art_url key="normal"
		@art_url[key]
	end
  def episodes
    @episodes.collect! do |episode_number|
      Episode.get(@podcast_id, episode_number)
    end
  end
  def self.filename(id)
    'data/podcasts/' + id + '.json'
  end
end

class Episode < Schema
  attr_accessor :episode_number, :title, :summary, :author, :url, :media_url, :podcast_id, :publish_date,
  :media_length, :media_size, :media_title, :media_artist, :media_album, :media_year, :media_track

  def self.get podcast_id, episode_number
  	'data/episodes/' + podcast_id + '/' + podcast_id + '_' + self.file_number(episode_number)
  end

  def self.file_number episode_number
  	begin
	  	"%03d" % Integer(episode_number)
	  rescue
	  	episode_number
	  end
  end

  def body
    if @body_html.nil?
      if @body.nil?
        @body = @summary
        @body_html = @body
      else
      	@body_html = markdown.render(File.read('data/episodes/' + @podcast_id + '/' + @podcast_id + '_' + self.file_number(@episode_number)))
      end
    end
    @body_html
  end

  def body_truncate
    truncate(body, :length => 255, :separator => "\n")
  end
end

helpers BrickcasterHelpers

get '/:podcast_id/:episode_number' do
  @podcast = Podcast.get(params[:podcast_id])
	@episode = Episode.get(params[:podcast_id], params[:episode_number])
	return erb :error if @episode.nil?
	erb :episode
end

get '/:podcast_id.json' do
	@podcast = Podcast.get(params[:podcast_id]);
	return erb :error if @podcast.nil?
	@podcast.json
end

get '/:podcast_id.rss' do
	@podcast = Podcast.get(params[:podcast_id]);
	return erb :error if @podcast.nil?
	builder :podcast_rss
end

get '/:podcast_id' do
	@podcast = Podcast.get(params[:podcast_id]);
	return erb :error if @podcast.nil?
	erb :podcast
end

get '/' do
  @index = Index.get
  erb :index
end