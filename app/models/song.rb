class Song < SwellMedia::Media


	def artist
		if self.properties.present?
			self.properties['artist']
		else
			''
		end
	end


	private
		def set_keywords_and_tags
			
		end
end