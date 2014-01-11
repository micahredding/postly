xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:atom" => "http://www.w3.org/2005/Atom", "xmlns:content"=>"http://purl.org/rss/1.0/modules/content/" do
  xml.channel do
    xml.atom :link, :href => podcast_rss_url(@podcast.shortname), :rel => "self", :type => "application/rss+xml"

    # id
    xml.link podcast_show_url(@podcast.shortname)

    # title, summary, content
    xml.title @podcast.title
    xml.itunes :subtitle, body_truncate(@podcast.body)
    xml.itunes :summary, @podcast.body
    xml.description @podcast.body

    # podcast image
    xml.itunes :image, :href => @podcast.art_url

    # podcast meta
    xml.language 'en-us'
    xml.copyright 'copyright © 2013 Micah Redding'
    xml.itunes :author, @podcast.author || 'Micah Redding'
    xml.itunes :owner do
      xml.itunes :name, 'Micah Redding'
      xml.itunes :email, 'micahtredding@gmail.com'
    end

    # categories
    xml.itunes :keywords, @podcast.keywords
    @podcast.categories.lines.each do |category|
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
    episodes.sort_by! { |e| e.publish_date.to_i }
    episodes.reverse!

    episodes.each do |episode|
      xml.item do
        # id
        xml.guid episode_show_url(@podcast.shortname, episode.episode_number)
        xml.link episode_show_url(@podcast.shortname, episode.episode_number)

        # title, summary, content
        xml.title episode.title
        xml.itunes :subtitle, episode.summary || body_truncate(episode.body)
        xml.itunes :summary, episode.summary || body_truncate(episode.body)
        xml.description episode.summary || body_truncate(episode.body)
        xml.content :encoded, body_encode(episode.body)

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
