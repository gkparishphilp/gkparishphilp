class NotesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :get_note, except: [ :admin, :create, :index ]

	def admin
		authorize( Note )
		sort_by = params[:sort_by] || 'due_at'
		sort_dir = params[:sort_dir] || 'desc'

		@notes = Note.order( "#{sort_by} #{sort_dir}" )

		if params[:status].present? && params[:status] != 'all'
			@notes = eval "@notes.#{params[:status]}"
		end

		@notes = @notes.page( params[:page] )

		render layout: 'admin'
	end

	def create
		@note = Note.new( note_params )

		@note.assigned_to_id ||= current_user
		@note.requested_by_id ||= current_user

		if @note.save
			if parent_note = Note.find_by( id: params[:note][:parent_id] )
				@note.move_to_child_of( parent_note )
			end

			set_flash "Note created"
		else
			set_flash "Note could not be saved.", :error, @note
		end

		redirect_to edit_note_path( @note )
	end

	def destroy
		@note.trash!
		redirect_to :back
	end

	def edit
		
	end

	def update
		authorize( @note )
		@note.attributes = note_params
		@note.completed_at = Time.zone.now if @note.completed?
		@note.confirmed_at = Time.zone.now if @note.confirmed?

		if @note.save
			set_flash 'Note Updated'
			redirect_to edit_note_path( id: @note.id )
		else
			set_flash 'Note could not be Updated', :error, @note
			render :edit
		end
	end


	private

		def get_note
			@note = Note.friendly.find( params[:id] )
		end

		def note_params
			params.require( :note ).permit( :assigned_to_id, :requested_by_id, :name, :description, :content, :status, :due_at, :availability, :priority, :remind_time, :tag_list, :category_id )
		end
end