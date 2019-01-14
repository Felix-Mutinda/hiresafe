class UsersController < Devise::RegistrationsController

	def new
		@user = User.new
	end
	
	def create
		super do |resource|
		  resource.balance = 10000
		end
	end
end
