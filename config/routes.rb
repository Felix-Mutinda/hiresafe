Rails.application.routes.draw do
	root 'dashboards#index'
	
	
	devise_for :users
	
	resources :users do
		resources :cars 
	end
	
	resources :cars do
		resources :hired_cars
	end
end
