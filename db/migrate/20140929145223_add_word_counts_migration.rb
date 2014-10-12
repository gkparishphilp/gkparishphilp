class AddWordCountsMigration < ActiveRecord::Migration
	def change
		add_column :media, :cached_word_count, :integer
		add_column :media, :cached_char_count, :integer
	end
end
