Rails.application.routes.draw do
  devise_for :users
  get 'plugs/:id/bookings/approve', to: 'bookings#approve', as: 'bookings_approve'
  resources :plugs, only: [:index] do
    resources :bookings, only: [:create, :show]
  end
  # get '/plugs', to: 'plugs#index'
  # root to: 'plugs#index'
  # post '/plugs/:id/bookings', to: 'bookings#create', as: 'bookings'
  # # get '/plugs/:id/bookings/new', to: 'bookings#new', as: 'bookings_new'
  # get 'bookings/:id/edit', to: 'bookings#edit', as: 'bookings_edit'
  # patch 'booking/:id', to: 'bookings#update', as: 'bookinga_update'
end
