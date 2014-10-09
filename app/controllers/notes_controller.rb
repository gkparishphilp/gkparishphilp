class NotesController < SwellMedia::MediaController

	def create
		authorize( Note )
		@note = Note.new( note_params )

		@note.publish_at ||= Time.zone.now
		@note.user = current_user
		@note.status = 'active'

		if @note.save
			set_flash 'Note Created'
			redirect_to main_app.edit_note_path( @note)
		else
			set_flash 'Note could not be created', :error, @note
			redirect_to :back
		end
	end


	def update
		authorize( @media )
			
		@media.attributes = note_params

		if @media.save
			set_flash 'Article Updated'
			redirect_to main_app.edit_note_path( id: @media.id )
		else
			set_flash 'Article could not be Updated', :error, @media
			render :edit
		end
	end

	private

		def note_params
			params.require( :note ).permit( :title, :subtitle, :content, :status, :publish_at, :is_commentable, :user_id, :tag_list, :avatar )
		end
end