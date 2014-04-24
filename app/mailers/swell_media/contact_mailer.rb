module SwellMedia
	class ContactMailer < ActionMailer::Base
		def new_contact( contact )
			@contact = contact
			mail to: 'gk@gkparishphilp.com', from: 'gk@gkparishphilp.com', subject: 'GkParishPhilp.com has a new contact!'
		end
	end
end