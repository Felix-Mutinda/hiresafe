Rails.application.routes.draw do
	root 'dashboards#index'
	
	get '/search', to: 'dashboards#search'
	
	devise_for :users, controllers: { registrations: 'users' }
		
	resources :users do
		resources :cars 
	end
	
	resources :cars do
		resources :hired_cars
	end
end
