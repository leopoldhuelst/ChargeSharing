Rails.application.routes.draw do
  devise_for :users
  root to: 'plugs#index'
  resources :users, only: %i[show edit update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'dashboards#show', as: 'dashboard'
  get 'plugs/:id/bookings/approve', to: 'bookings#approve', as: 'bookings_approve'
  resources :plugs, only: [:index] do
    resources :bookings, only: %i[create show]
  end
  # get '/plugs', to: 'plugs#index'
  # root to: 'plugs#index'
  # post '/plugs/:id/bookings', to: 'bookings#create', as: 'bookings'
  # # get '/plugs/:id/bookings/new', to: 'bookings#new', as: 'bookings_new'
  # get 'bookings/:id/edit', to: 'bookings#edit', as: 'bookings_edit'
  # patch 'booking/:id', to: 'bookings#update', as: 'bookinga_update'
end
