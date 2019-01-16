class HiredCarsController < ApplicationController

	def new
		@user = User.find_by(id: params[:user_id])
	end
	
	
	def create
		@user = User.find_by(id: params[:user_id])
		@hired_car = @user.hired_cars.create(hired_car_params)
		
		redirect_to user_hired_cars_path(@user)
	end
	
	
	protected
		def hired_car_params
			params.require(:hired_car).permit(:days)
		end
end
