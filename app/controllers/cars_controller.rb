class CarsController < ApplicationController
	
	
	def new
		@user = User.find_by(id: params[:user_id])
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
