require 'sinatra'
require 'sinatra/base'
require 'sinatra/content_for'
require 'json'
require 'builder'
require 'redcarpet'
require 'nokogiri'
require 'uri'
require 'pry'

require_relative 'constants'
require_relative 'helpers'
require_relative 'model/post'
require_relative 'model/stream'
require_relative 'dao/post_dao'
require_relative 'dao/stream_dao'
require_relative 'presenter/post_presenter'
require_relative 'presenter/stream_presenter'

class PostlyRoutes < Sinatra::Base
  helpers Sinatra::ContentFor
  helpers PostlyViewHelpers

  sql_interface = SQLInterface.new
  sql_interface.setup_database

  post_translator = PostTranslator.new
  stream_translator = StreamTranslator.new
  post_translator.import
  stream_translator.import

  get '/posts/:id' do
    dao = PostSQLDao.new
    post = dao.get_post params[:id]
    @post_presenter = PostPresenter.new post
    erb :post
  end

  get '/streams/:id.?:format?' do
    dao = StreamSQLDao.new
    stream = dao.get_stream params[:id]
    dao = PostSQLDao.new
    posts = dao.get_posts_from_list(stream.post_ids)
    @stream_presenter = StreamPresenter.new stream, posts
    case params[:format]
      when "rss"
        builder :stream
      else
        erb :stream
    end
  end

  # get '/' do
  #   dao = StreamDao.new
  #   @streams = dao.get_all
  #   erb :index
  # end

  not_found do
    "Could not find that"
  end

end