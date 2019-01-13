class UsersController < Devise::RegistrationsController

	def new
		@user = User.new
	end
	
	def create
		render plain: user_params
	end
	
	private
		def sign_up_params
			params.require(:user).permit(:name, :nat_id, :location, :email, :password, :password_confirmation)
		end

		def account_update_params
			params.require(:user).permit(:name, :nat_id, :location, :email, :password, :password_confirmation, :current_password)
		end
end
