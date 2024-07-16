Rails.application.routes.draw do
  get 'registrations/new'
  get 'registrations/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users do
    resources :loans, only: [:new, :create, :show, :update]
  end

  resources :admins do
    resources :loans, only: [:show, :update]
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'users#index'
end
