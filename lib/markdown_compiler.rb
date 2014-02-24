require 'redcarpet'

class MarkdownCompiler
  class HTMLWithEmbeds < Redcarpet::Render::HTML
    def header(text, level, anchor)
      level += 1
      "<h#{level}>#{text}</h#{level}>"
    end

    def autolink(link, link_type)
      regex = /(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?(\w{10,})/
      matches = link.match(regex)
      if matches
        '<iframe width="640" height="360" src="//www.youtube.com/embed/' + matches[1] + '?rel=0" frameborder="0" allowfullscreen></iframe>'
      else
        '<a href="' + link + '">' + link + '</a>'
      end
    end
  end

  def initialize
    @markdown = Redcarpet::Markdown.new(
      HTMLWithEmbeds.new(:link_attributes => Hash["target" => "_blank"]),
      :hard_wrap => true,
      :autolink => true,
      :space_after_headers => true
    )
  end

  def compile(markdown_text)
    @markdown.render markdown_text
  end
end
