class DashboardsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :search]
	
	def index
		@user = current_user
		@car = Car.first
		
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
	
		if @user 
			@list_car_path = new_user_car_path(@user)
		else
			@list_car_path = new_user_session_path
		end
		
	
	end
	
	def search
		@user = current_user
		@car = Car.first
		@available_cars = Car.all

		if !params[:model].strip.empty?
			@available_cars = @available_cars.where("model  ilike ?", '%'+params[:model]+'%')
		end
		
		if !params[:price].strip.empty?
			@available_cars = @available_cars.where("price  <= ?", params[:price])
		end
		
		if !params[:location].strip.empty?
			@available_cars = @available_cars.where("location  ilike ?", '%'+params[:location]+'%')
		end
		
		render "dashboards/search_result"
=begin		
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
=end
	end
end
