class DashboardsController < ApplicationController
	
	
	def index
		@user = current_user
		
		if current_user.user_type == "1" # client
			render 'dashboards/client_index'
			
		else #owner
			render 'dashboards/owner_index'
		end
	end
end
