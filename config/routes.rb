Rails.application.routes.draw do
  resources :doctrines
  resources :fittings
  resources :stagings

  root to: 'root#index'
end
