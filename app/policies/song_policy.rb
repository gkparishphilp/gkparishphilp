
class SongPolicy < ApplicationPolicy
	
	def admin?
		user.admin?
	end

	def create?
		user.admin?
	end

	def destroy?
		user.admin?
	end

	def edit?
		user.admin?
	end

	def preview?
		user.admin?
	end

	def update?
		user.admin?
	end
end
