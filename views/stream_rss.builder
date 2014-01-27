xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:atom" => "http://www.w3.org/2005/Atom", "xmlns:content"=>"http://purl.org/rss/1.0/modules/content/" do
  xml.channel do
    xml.atom :link, :href => request.host + @stream.url, :rel => "self", :type => "application/rss+xml"

    # id
    xml.link request.scheme + '://' + request.host + '/' + @stream.url

    # title, summary, content
    xml.title @stream.title
    # xml.itunes :subtitle, @podcast.description
    # xml.itunes :summary, @podcast.description
    # xml.description @podcast.description

    # podcast image
    # xml.itunes :image, :href => @podcast.art_url

    # podcast meta
    xml.language 'en-us'
    xml.copyright 'copyright © 2012-2014 Micah Redding'
    xml.itunes :author, 'Micah Redding'
    xml.itunes :owner do
      xml.itunes :name, 'Micah Redding'
      xml.itunes :email, 'micahtredding@gmail.com'
    end

    # categories
    # xml.itunes :keywords, @podcast.keywords
    # @podcast.categories.each do |category|
    #   subcategories = category.split(/, /)
    #   if subcategories.size > 1
    #     xml.itunes :category, :text => subcategories[0].chomp do
    #       xml.itunes :category, :text => subcategories[1].chomp
    #     end
    #   else
    #     xml.itunes :category, :text => category.chomp
    #   end
    # end

    posts = @stream.posts
    posts.reverse!

    posts.each do |post|
      xml.item do
        # id
        xml.guid request.scheme + '://' + request.host + '/' + post.url
        xml.link request.scheme + '://' + request.host + '/' + post.url

        # title, summary, content
        xml.title post.title
        # xml.itunes :subtitle, post.summary || body_truncate
        # xml.itunes :summary, post.summary || body_truncate
        xml.description post.content
        xml.content :encoded, post.content

        # post media
        # xml.enclosure :url => post.media_url, :length => post.media_size, :type => 'audio/mpeg'

        # post meta
        # xml.pubDate format_date(post.publish_date)
        # xml.itunes :duration, format_length(post.media_length)

        # podcast meta
        xml.itunes :author, 'Micah Redding'
        # xml.itunes :image, :href => @podcast.art_url
        # xml.itunes :keywords, @podcast.keywords
      end
    end
  end
end
