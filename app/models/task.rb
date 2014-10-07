class task < ActiveRecord::Base

	attr_accessor	:parent_id # for building parent associations in form_for

	enum status: { 'pending' => 0, 'active' => 1, 'completed' => 2, 'confirmed' => 3, 'trash' => 4 }
	enum availability: { 'just_me' => 0, 'team' => 1, 'anyone' => 2 }

	belongs_to	:assigned_to, class_name: 'User'
	belongs_to 	:requested_by, class_name: 'User'
	belongs_to	:category

	has_many	:assets
	has_many	:timers

	extend FriendlyId
	friendly_id :name, :use => :slugged

	acts_as_nested_set

	acts_as_taggable_on	:tags

end