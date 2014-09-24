class AdminController < SwellMedia::AdminController

	before_filter :authenticate_user!

	def index
		raise Pundit::NotAuthorizedError, "not authorized" unless current_user.admin?
		@articles = SwellMedia::Article.order( publish_at: :desc ).limit( 10 )
		@pages = SwellMedia::Page.order( publish_at: :desc ).limit( 10 )
		@contacts = SwellMedia::Contact.order( created_at: :desc ).limit( 10 )

		render layout: 'admin'
	end

	
end