class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	before_action :authenticate_user!
	
	protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :nat_id, :location, :email, :password) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :nat_id, :location, :email, :password, :current_password) }
        end
end
