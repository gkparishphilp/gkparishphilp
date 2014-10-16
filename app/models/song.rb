class Song < SwellMedia::Media


	def artist
		if self.properties.present?
			self.properties['artist']
		else
			''
		end
	end
end