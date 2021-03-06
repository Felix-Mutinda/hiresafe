class HiredCarsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:new, :create]
	
	def index
		@user = current_user
		@my_hired_cars = HiredCar.where(user_id: @user.id)
		
		@car_details = []
		Car.all.each do |car|
			@my_hired_cars.all.each do |h_c|
				if car.id == h_c.car_id
					@car_details.push([car, h_c])
					break
				end
			end
		end
	end
	
	# used as destroy
	def show
		HiredCar.destroy(params[:id])
		
		redirect_to  root_path
	end
	
	def new
		@car = Car.find_by(id: params[:car_id])
		@h_days =  session[:hire_days]
	end
	
	
	def create
		@user = current_user
		@car = Car.find_by(id: params[:car_id])
		
		if user_signed_in?
			if !HiredCar.find_by(car_id: params[:car_id])
			    
			    # pay for a car before hiring another
			    pending = false
			    HiredCar.all.each do |car|
			        if car.user_id == @user.id and car.payment == "pending"
			            flash[:alert] = "Please complete a pending payment first"
			            #redirect_to car_hired_cars_path(car)
			            pending = true
			            break
			        end
			    end
			    
			    if !pending
    				@hired_car = @car.hired_cars.create(hired_car_params)
    				HiredCar.update(@hired_car.id, payment: 'pending') # payment defaults to 'pending'
    				HiredCar.update(@hired_car.id, user_id: @user.id)
    				
    				# add pickup and return dates to hired_cars table
    				HiredCar.update(@hired_car.id, start_date: session[:start_date])
    				HiredCar.update(@hired_car.id, end_date: session[:end_date])
    			end
			end

			#render plain: params
			redirect_to car_hired_cars_path(@car)
		else
			session[:hire_car_data] = {"car_id"=> params[:car_id], "hired_car_params"=> hired_car_params}
			flash[:alert] = "To Complete this transaction please login"
			
			redirect_to new_user_session_path
		end
	end
	
	def destroy
		
	end
	
	
	protected
		def hired_car_params
			params.require(:hired_car).permit(:days)
		end
end
