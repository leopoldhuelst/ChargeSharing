Rails.application.routes.draw do
  devise_for :users
  root to: 'plugs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/plugs', to: 'plugs#index'
  get '/dashboard', to: 'dashboards#show', as: 'dashboard'
end
