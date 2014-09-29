class AddWordCountMigration < ActiveRecord::Migration
	def change
		add_column :media, :cached_word_count, :integer
	end
end
