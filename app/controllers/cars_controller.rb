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
		
		case @car.model.to_i
		when 1
			Car.update(@car.id, price: 2500)
		when 2
			Car.update(@car.id, price: 2000)
		when 3
			Car.update(@car.id, price: 10000)
		when 4
			Car.update(@car.id, price: 7500)
		when 5
			Car.update(@car.id, price: 2500)
		else
			Car.update(@car.id, price: 00) # unspecified
		end
		
		flash[:notice] = "Your Car Has Successfully Been Listed"
		redirect_to root_path
	end
	
	private
    def car_params
      params.require(:car).permit(:model, :transmission, :location, :insurance_no, :image)
    end
end
