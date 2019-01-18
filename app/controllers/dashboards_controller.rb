class DashboardsController < ApplicationController
	
	
	def index
		@user = current_user
		@car = Car.first
		
		if current_user.user_type == "1" # client
			@available_cars = []
			hired = false
			
			Car.all.each do |car|
				
				HiredCar.all.each do |hired_car|
					if car.id == hired_car.car_id
						hired = true
						break
					end
				end
				
				
				if !hired
					@available_cars.push(car)
				end
				hired = false
			end
			
			render 'dashboards/client_index'
			
		else #owner
			render 'dashboards/owner_index'
		end
	end
end
