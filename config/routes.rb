Rails.application.routes.draw do
  devise_for :users
  root to: 'plugs#index'
  resources :users, only: %i[show edit update]
  get '/dashboard', to: 'dashboards#show', as: 'dashboard'
  get 'plugs/new', to: 'plugs#new'
  post 'plugs', to: 'plugs#create'
  get 'plugs/:plug_id/bookings/approve', to: 'bookings#approve', as: 'bookings_approve'
  get 'plugs/:plug_id/bookings/:id/stop', to: 'bookings#stop_booking', as: 'bookings_stop'
  delete 'plugs/:id', to: 'plugs#destroy', as: 'destroy_plug'
  resources :plugs, only: %i[index edit update destroy create] do
    resources :bookings, only: %i[create show]
  end
  get 'bookings/:id/reviews/new', to: 'reviews#new', as: 'review_booking_new'
  post 'bookings/:id/reviews', to: 'reviews#create', as: 'booking_reviews'
  get 'bookings/:id/favourites', to: 'favourites#add', as: 'add_favourites'
  get 'create_payment_id/:plug_id/:id', to: 'bookings#save_payment'
end
