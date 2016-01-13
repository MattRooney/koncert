Rails.application.routes.draw do
  root "home#index"
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/logout', to: "sessions#destroy", as: :logout
  resources :playlists, only: [:new]
  resources :users, only: [:show]
end
