class TasksMigration < ActiveRecord::Migration
	def change

		create_table :assets do |t|
			t.references 		:parent_obj, polymorphic: true
			t.references		:user
			t.text				:origin_url
			t.string			:file 		# for carrier wave
			t.string			:type
			t.text				:description
			t.text				:content
			t.integer			:status, 					default: 0
			t.timestamps
		end


		create_table :tasks do |t|
			t.references		:assigned_to
			t.references		:requested_by
			t.references 		:category
			t.references		:parent
			t.integer			:lft
			t.integer			:rgt
			t.string			:type
			t.string			:name
			t.text				:description
			t.text				:content
			t.integer			:status,					default: 0
			t.integer 			:priority, 					default: 0
			t.integer			:cached_duration,			default: 0 # total worked in minutes from timers
			t.string 			:slug
			t.datetime			:due_at
			t.datetime			:started_at
			t.datetime			:completed_at
			t.datetime			:confirmed_at
			t.timestamps
		end


		resources :timers do
			t.references		:parent_obj, polymorphic: true
			t.references		:user
			t.datetime			:started_at
			t.datetime			:ended_at
			t.integer			:cached_duration	# in minutes
			t.text				:notes
			t.integer			:status,			default: 1
			t.timestamps
		end
		add_index :timers, [ :parent_obj_id, :parent_obj_type ]
		add_index :timers, :user_id

	end
end
