Rails.application.routes.draw do
	root 'dashboards#index'
	
	get '/search', to: 'dashboards#search'
	
	# payments urls
	get '/payments/show_token', to: 'payments#show_token' # dev only
	get '/payments/register', to: 'payments#register'  # dev only
	
    post '/payments/confirm', to: 'payments#confirm'
    post '/payments/validate', to: 'payments#validate'
    
    get '/payments/c2bsimulate', to: 'payments#c2bsimulate' #dev only
    
    post '/payments/lnm_callback', to: 'payments#lnm_callback'
    get '/payments/stk_push', to: 'payments#stkpush'

	devise_for :users, controllers: { registrations: 'users' }
		
	resources :users do
		resources :cars 
	end
	
	resources :cars do
		resources :hired_cars
	end
end
