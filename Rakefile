require_relative 'constants'
require_relative 'dao/post_dao'
require_relative 'dao/stream_dao'
require_relative 'dao/filesystem/translator'
require_relative 'dao/filesystem/post_dao'
require_relative 'dao/filesystem/stream_dao'
require "#{Postly::LIB_PATH}/markdown_compiler"

namespace :postly do

  task :setup_database do
    sql_dao = SQLDao.new
    sql_dao.setup_database
  end

  task :import_to_database do
    post_translator = PostTranslator.new
    stream_translator = StreamTranslator.new
    post_translator.import
    stream_translator.import
  end

  task :prep => [:setup_database, :import_to_database] do
    puts 'Imported from files to database'
  end

end