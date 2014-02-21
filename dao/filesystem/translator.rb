class Translator
  def import(source, destination)
    destination.import_to_database source.index
  end
end

class PostTranslator < Translator
  def import
    source = PostYamlDao.new
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
