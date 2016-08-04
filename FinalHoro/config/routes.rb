Rails.application.routes.draw do
  resources :users
  root 'users#new'
  get '/signup', to: 'users#new'
  get '/index', to: 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
