require "#{Postly::TRANSLATOR_PATH}/meta_dao"
require "#{Postly::TRANSLATOR_PATH}/post_dao"
require "#{Postly::TRANSLATOR_PATH}/stream_dao"
require "#{Postly::MAPPER_PATH}/post_mapper"

class Translator
  def import(source, destination)
    destination.import_to_database source.index
  end
end

class PostTranslator < Translator
  def import
    source = PostMarkdownDao.new
    destination = PostSQLInterface.new
    super source, destination
  end
end

class StreamTranslator < Translator
  def import
    source = StreamYamlDao.new
    destination = StreamSQLInterface.new
    super source, destination
  end
end
