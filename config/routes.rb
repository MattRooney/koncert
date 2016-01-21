Rails.application.routes.draw do
  root "home#index"
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/logout', to: "sessions#destroy", as: :logout
  get '/about', to: "home#show", as: :about
  get '/current', to: "users#current"
  resources :users, only: [:show]
  resources :playlists

  get '*unmatched_route', to: 'application#not_found'
end
