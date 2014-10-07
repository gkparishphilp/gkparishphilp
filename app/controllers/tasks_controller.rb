class TasksController < ApplicationController

	before_filter :authenticate_user!
	before_filter :get_task, except: [ :admin, :create, :index ]

	def admin
		authorize( Task )
		sort_by = params[:sort_by] || 'due_at'
		sort_dir = params[:sort_dir] || 'desc'

		@tasks = Task.roots.order( "#{sort_by} #{sort_dir}" )

		if params[:status].present? && params[:status] != 'all'
			@tasks = eval "@tasks.#{params[:status]}"
		end

		@tasks = @tasks.page( params[:page] )

		render layout: 'admin'
	end

	def create
		@task = Task.new( task_params )

		@task.assigned_to_id ||= current_user
		@task.requested_by_id ||= current_user

		if @task.save
			if parent_task = Task.find_by( id: params[:task][:parent_id] )
				@task.move_to_child_of( parent_task )
			end

			set_flash "Task created"
		else
			set_flash "Task could not be saved.", :error, @task
		end

		redirect_to edit_task_path( @task )
	end

	def destroy
		@task.trash!
		redirect_to :back
	end

	def edit
		
		render layout: 'admin'
	end

	def update
		authorize( @task )
		@task.attributes = task_params
		@task.completed_at = Time.zone.now if @task.completed?
		@task.confirmed_at = Time.zone.now if @task.confirmed?

		if @task.save
			set_flash 'Task Updated'
			redirect_to edit_task_path( id: @task.id )
		else
			set_flash 'Task could not be Updated', :error, @task
			render :edit
		end
	end


	private

		def get_task
			@task = Task.friendly.find( params[:id] )
		end

		def task_params
			params.require( :task ).permit( :assigned_to_id, :requested_by_id, :name, :description, :content, :status, :due_at, :availability, :priority, :remind_time, :tag_list, :category_id )
		end
end