class DashboardsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :search]
	
	def index
		@user = current_user
		@car = Car.first
		
		@available_cars = []
		hired = false
		data = session[:hire_car_data]
		
		if user_signed_in? and data
			if !HiredCar.find_by(car_id: data["car_id"])
				@hired_car = @car.hired_cars.create(data["hired_car_params"])
				HiredCar.update(@hired_car.id, user_id: @user.id)
			end
			
			session[:hire_car_data] = nil
			
			#render plain: params
			redirect_to car_hired_cars_path(@car)
			
		end
		
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
			@user = User.new
			@user.id = 0
			@list_car_path = new_user_car_path(@user)
		end
		
	
	end
	
	def search
		@user = current_user
		@car = Car.first
		@available_cars = Car.all

		if !params[:model].strip.empty?
			@available_cars = @available_cars.where("model  like ?", '%'+params[:model]+'%')
		end
		
		if !params[:location].strip.empty?
			@available_cars = @available_cars.where("location  like ?", '%'+params[:location]+'%')
		end
		
		cars = @available_cars
		@available_cars = []
		hired = false
		
		cars.each do |car|
			
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
		
		render "dashboards/search_result"
	end
end
