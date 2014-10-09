class Maxim < SwellMedia::Media

	# a short quote, saying, or aphorism... 
	# sometimes mine, sometimes attributed
	# wiht own template/styling....
	# thinking large font + cover bg image
	# Poetry + Philosophy: I just can't resist these...

	
	def self.random
		Maxim.order( 'random()' ).last
	end

	def slugger
		self.slug_pref.present? ? self.slug_pref : self.content
	end

	private
		def allow_blank_title
			true
		end
end