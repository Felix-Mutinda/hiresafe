Rails.application.routes.draw do
	root 'dashboards#index'
	
	get '/search', to: 'dashboards#search'
	get '/payments/show_token', to: 'payments#show_token'
	get '/payments/register', to: 'payments#register'
    get '/payments/confirm', to: 'payments#confirm'
    get '/payments/validate', to: 'payments#validate'
    
    
	devise_for :users, controllers: { registrations: 'users' }
		
	resources :users do
		resources :cars 
	end
	
	resources :cars do
		resources :hired_cars
	end
end
