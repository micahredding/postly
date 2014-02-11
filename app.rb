require 'sinatra'
require 'json'
require 'builder'
require 'redcarpet'
require 'nokogiri'
require 'uri'
require 'pry'

require_relative 'helpers'
require_relative 'stream'
require_relative 'post'
require_relative 'mappers'
require_relative 'controllers'

get '/posts/:post_id' do
  @post = PostController.load(params[:post_id])
  redirect '/' if @post.nil?
	erb :post
end

get '/:stream_id.rss' do
  @stream = StreamController.load(params[:stream_id])
  redirect '/' if @stream.nil?
	builder :stream_rss
end

get '/:stream_id' do
  @stream = StreamController.load(params[:stream_id])
  redirect '/' if @stream.nil?
	erb :stream
end

get '/' do
  @streams = StreamController.index
  erb :index
end