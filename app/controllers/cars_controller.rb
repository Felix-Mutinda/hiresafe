class CarsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:new, ]
	
	def new
		if user_signed_in?
			@user = User.find_by(id: params[:user_id])
		else
			flash[:alert] = "To list a car, please signin first"
			redirect_to new_user_session_path
		end
		
	end
	
	def create
		@user = User.find_by(id: params[:user_id])
		@car = @user.cars.create(car_params)
		#@car.price = 10000
		Car.update(@car.id, price: 3500)
		
		redirect_to root_path
	end
	
	private
    def car_params
      params.require(:car).permit(:model, :transmission, :location)
    end
end
