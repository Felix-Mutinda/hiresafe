class DashboardsController < ApplicationController
	
	
	def index
		@user = current_user
		byebug
	end
end
