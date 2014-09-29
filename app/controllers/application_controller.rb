class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	helper SwellMedia::Engine.helpers

	before_filter :set_page_meta


	private

		def user_not_authorized
			set_flash "You are not authorized to perform this action.", :danger
			redirect_to root_path
		end

end