Rails.application.routes.draw do
	root 'dashboards#index'
	
	
	devise_for :users
	
	resources :users do
		resources :cars
	end
end
