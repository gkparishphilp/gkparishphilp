class TasksMigration < ActiveRecord::Migration
	drop_table :tasks
	drop_table :timers
	
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
		t.integer			:availability,				default: 0
		t.integer 			:priority, 					default: 1
		t.integer			:remind_time,				default: 0 # remind-before in minutes 0 = off
		t.integer			:cached_duration,			default: 0 # total worked in minutes from timers
		t.string 			:slug
		t.datetime			:due_at
		t.datetime			:started_at
		t.datetime			:completed_at
		t.datetime			:confirmed_at
		t.timestamps
	end

	create_table :timers do |t|
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