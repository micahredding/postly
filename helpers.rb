module PostlyViewHelpers

	def base_url
		return "#{request.scheme}://#{request.host}:#{request.port}" if request.port != 80
    "#{request.scheme}://#{request.host}"
	end

  def twitter_url(presenter)
    return base_url if presenter.nil?
    base_url + presenter.path
  end

  def twitter_status_from_presenter(presenter)
    return Postly::SITE_NAME if presenter.nil?
    presenter.twitter_status
  end

	def twitter_status(presenter)
		 twitter_status_from_presenter(presenter) + ' ' + twitter_url(presenter) + ' via @' + Postly::USER_TWITTER_HANDLE
	end

	def encoded_twitter_status(presenter)
		URI.encode(twitter_status(presenter))
	end

end