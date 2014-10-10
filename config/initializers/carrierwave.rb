if ENV['FOG_DIRECTORY']
	CarrierWave.configure do |config|
		config.fog_credentials = {
				:provider               => 'AWS',       # required
				:aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],       # required
				:aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],       # required
		}
		config.fog_directory  = ENV['FOG_DIRECTORY'] # required
		# see https://github.com/jnicklas/carrierwave#using-amazon-s3
		# for more optional configuration

		config.validate_unique_filename = false        # defaults to true
		config.validate_filename_format = false        # defaults to true
		config.validate_remote_net_url_format = false  # defaults to true
		config.cache_dir = "#{Rails.root}/tmp/uploads"
		#config.fog_public     = true
	end
end