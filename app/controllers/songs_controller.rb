class SongsController < SwellMedia::MediaController

	def create
		authorize( Song )
		@song = Song.new( song_params )

		@song.publish_at ||= Time.zone.now
		@song.user = current_user
		@song.status = 'active'

		if @song.save
			set_flash 'Song Created'
			redirect_to main_app.edit_song_path( @song)
		else
			set_flash 'Song could not be created', :error, @song
			redirect_to :back
		end
	end


	def update
		authorize( @media )
			
		@media.attributes = song_params

		if @media.save
			set_flash 'Song Updated'
			redirect_to main_app.edit_song_path( id: @media.id )
		else
			set_flash 'Song could not be Updated', :error, @media
			render :edit
		end
	end

	private

		def song_params
			params.require( :song ).permit( :title, :subtitle, :content, :status, :publish_at, :is_commentable, :user_id, :tag_list, properties: [ :artist ] )
		end
end