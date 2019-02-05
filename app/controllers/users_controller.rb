class UsersController < Devise::RegistrationsController

	def new
		@user = User.new
	end
	
	def create
		super do |resource|
		  resource.balance = 10000
		end
	end
	
	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end
end
