class Note < SwellMedia::Media

	before_create	:make_private


	private
		def allow_blank_title
			true
		end

		def make_private
			self.availability = 'just_me'
		end
end