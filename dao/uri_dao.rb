require 'open-uri'

class UriDao
  def load_and_parse(filename)
    open(filename) do |f|
      f.read
    end
  end
end


class MarkdownDao < UriDao
  def load_and_parse(filename)
    super filename
  end
end
