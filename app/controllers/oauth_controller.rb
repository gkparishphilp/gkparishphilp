class OauthController < Devise::OmniauthCallbacksController

	def twitter

		@response = TwitterParser.new( request.env["omniauth.auth"] )

		credential = OauthCredential.where( provider: @response.provider, uid: @response.uid ).first

		credential = current_user.oauth_credentials.create!( @response.credential_fields )
		set_flash "#{credential.provider} account added."
		
		redirect_to admin_index_path

	end
end