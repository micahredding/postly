module PostlyViewHelpers

	def base_url
		request.scheme + '://' + request.host
	end

	def twitter_status(presenter)
		presenter.twitter_status + ' ' + base_url + presenter.path + ' ' + Postly::USER_TWITTER_HANDLE
	end

	def encoded_twitter_status(presenter)
		URI.encode(twitter_status(presenter))
	end

end