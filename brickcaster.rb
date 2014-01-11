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

class Podcast < Schema
	attr_accessor :title, :podcast_id, :url, :itunes_url, :rss_url, :description
end

class Episode < Schema
  attr_accessor :episode_number, :title, :summary, :author, :media_url, :podcast_id, :publish_date
  # :media_length, :media_size, :media_title, :media_artist, :media_album, :media_year, :media_track

  def self.get podcast_id, episode_number
  	super podcast_id + '_' + self.file_number(episode_number)
  end

  def self.file_number episode_number
  	begin
	  	"%03d" % Integer(episode_number)
	  rescue
	  	episode_number
	  end
  end

  def body
  	@body_html ||= markdown.render(File.read('data/' + @body))
  end

end

get '/:podcast_id/:episode_number' do
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
