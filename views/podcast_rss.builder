xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:atom" => "http://www.w3.org/2005/Atom", "xmlns:content"=>"http://purl.org/rss/1.0/modules/content/" do
  xml.channel do
    xml.atom :link, :href => @podcast.rss_url, :rel => "self", :type => "application/rss+xml"

    # id
    xml.link @podcast.url

    # title, summary, content
    xml.title @podcast.title
    xml.itunes :subtitle, @podcast.description
    xml.itunes :summary, @podcast.description
    xml.description @podcast.description

    # podcast image
    xml.itunes :image, :href => @podcast.art_url

    # podcast meta
    xml.language 'en-us'
    xml.copyright 'copyright © 2012-2014 Micah Redding'
    xml.itunes :author, @podcast.author || 'Micah Redding'
    xml.itunes :owner do
      xml.itunes :name, 'Micah Redding'
      xml.itunes :email, 'micahtredding@gmail.com'
    end

    # categories
    xml.itunes :keywords, @podcast.keywords
    @podcast.categories.each do |category|
      subcategories = category.split(/, /)
      if subcategories.size > 1
        xml.itunes :category, :text => subcategories[0].chomp do
          xml.itunes :category, :text => subcategories[1].chomp
        end
      else
        xml.itunes :category, :text => category.chomp
      end
    end

    episodes = @podcast.episodes
    episodes.reverse!

    episodes.each do |episode|
      xml.item do
        # id
        xml.guid episode.url
        xml.link episode.url

        # title, summary, content
        xml.title episode.title
        xml.itunes :subtitle, episode.summary || body_truncate
        xml.itunes :summary, episode.summary || body_truncate
        xml.description episode.summary || body_truncate
        xml.content :encoded, episode.body

        # episode media
        xml.enclosure :url => episode.media_url, :length => episode.media_size, :type => 'audio/mpeg'

        # episode meta
        xml.pubDate format_date(episode.publish_date)
        xml.itunes :duration, format_length(episode.media_length)

        # podcast meta
        xml.itunes :author,  @podcast.author || 'Micah Redding'
        xml.itunes :image, :href => @podcast.art_url
        xml.itunes :keywords, @podcast.keywords
      end
    end
  end
end
