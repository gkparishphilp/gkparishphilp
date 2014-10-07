class TwitterClient

	def initialize( user )
		return nil unless  credential = user.oauth_credentials.where( provider: 'twitter' ).last
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['TWITTER_KEY']
			config.consumer_secret     = ENV['TWITTER_SECRET']
			config.access_token        = credential.try( :token )
			config.access_token_secret = credential.try( :secret )
		end
	end

	def followers
		@client.followers
	end

	def followers_count
		@client.user.followers_count
	end

	def following
		@client.friends
	end

	def following_count
		@client.user.friends_count
	end

	def non_followers_count
		( client.friend_ids.to_a - client.follower_ids.to_a ).size
	end

	def tweet( msg )
		@client.update( msg )
	end

	def tweets_count
		@client.user.tweets_count
	end

end