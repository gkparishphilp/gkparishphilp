class MaximsController < SwellMedia::MediaController

	def admin
		@media = Maxim.where.not( status: :trash ).( page: params[:page] )
	end

	def create
		authorize( Maxim )
		@maxim = Maxim.new( maxim_params )

		@maxim.publish_at ||= Time.zone.now
		@maxim.user = current_user
		@maxim.status = 'draft'

		if @maxim.save
			set_flash 'Maxim Created'
			redirect_to main_app.edit_maxim_path( @maxim)
		else
			set_flash 'Media could not be created', :error, @maxim
			redirect_to :back
		end
	end

	def random
		redirect_to Maxim.published.random.url
	end

	def update
		authorize( @media )
			
		@media.attributes = maxim_params

		if @media.save
			set_flash 'Article Updated'
			redirect_to main_app.edit_maxim_path( id: @media.id )
		else
			set_flash 'Article could not be Updated', :error, @media
			render :edit
		end
	end

	private

		def maxim_params
			params.require( :maxim ).permit( :title, :subtitle, :content, :status, :publish_at, :is_commentable, :user_id, :tag_list, :avatar, :avatar_asset_file, :avatar_asset_url )
		end
end