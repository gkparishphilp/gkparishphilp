Rails.application.routes.draw do

	resources :admin, only: :index do
		post :add, on: :collection
	end

	devise_scope :user do
		get '/login' => 'sessions#new', as: 'login'
		get '/logout' => 'sessions#destroy', as: 'logout'
	end
	devise_for :users, :controllers => { :omniauth_callbacks => 'oauth', :sessions => 'sessions' }

	mount SwellMedia::Engine, :at => '/'

end
