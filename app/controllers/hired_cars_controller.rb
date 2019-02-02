class HiredCarsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:new, ]
	
	def index
		@user = current_user
		@my_hired_cars = HiredCar.where(user_id: @user.id)
		
		@car_details = []
		Car.all.each do |car|
			@my_hired_cars.all.each do |h_c|
				if car.id == h_c.car_id
					@car_details.push(car)
					break
				end
			end
		end
	end
	
	def new
		@car = Car.find_by(id: params[:car_id])
	end
	
	
	def create
		@user = current_user
		@car = Car.find_by(id: params[:car_id])
		
		if !HiredCar.find_by(car_id: params[:car_id])
			@hired_car = @car.hired_cars.create(hired_car_params)
			HiredCar.update(@hired_car.id, user_id: @user.id)
		end
		
		#render plain: params
		redirect_to car_hired_cars_path(@car)
	end
	
	def destroy
		
	end
	
	
	protected
		def hired_car_params
			params.require(:hired_car).permit(:days)
		end
end
