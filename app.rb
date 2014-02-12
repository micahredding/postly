require 'sinatra'
require 'sinatra/content_for'
require 'json'
require 'builder'
require 'redcarpet'
require 'nokogiri'
require 'uri'
require 'pry'

require_relative 'helpers'
require_relative 'dao/post_dao'
require_relative 'dao/stream_dao'
require_relative 'presenter/post_presenter'

get '/posts/:id' do
  dao = PostDao.new
  post = dao.get_post params[:id]
  @post_presenter = PostPresenter.new post
  erb :post
end

get '/streams/:id.?:format?' do
  dao = StreamDao.new
  stream = dao.get_stream params[:id]
  @stream_presenter = StreamPresenter.new stream
  case params[:format]
    when "rss"
      builder :stream
    else
      erb :stream
  end
end

get '/' do
  dao = StreamDao.new
  @streams = dao.get_all
  erb :index
end

not_found do
  "Could not find that"
end

module Postly
  APPLICATION_PATH = File.dirname(__FILE__);
  DATA_PATH = "#{APPLICATION_PATH}/data";
  DAO_PATH = "#{APPLICATION_PATH}/dao";
  MAPPER_PATH = "#{APPLICATION_PATH}/mapper";
  MODEL_PATH = "#{APPLICATION_PATH}/model";
  LIB_PATH = "#{LIB_PATH}/lib";
end
