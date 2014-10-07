class AdminController < SwellMedia::AdminController

	before_filter :authenticate_user!

	def add
		# for quick-add
		die
	end

	def index
		raise Pundit::NotAuthorizedError, "not authorized" unless current_user.admin?
		@tasks = Task.roots.order( due_at: :desc ).limit( 10 )
		@articles = SwellMedia::Article.draft.order( publish_at: :desc ).limit( 10 )
		@contacts = SwellMedia::Contact.order( created_at: :desc ).limit( 10 )

		render layout: 'admin'
	end

	
end