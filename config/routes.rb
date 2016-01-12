Rails.application.routes.draw do
  root "home#index"
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'sessions#create'
  resources :playlists, only: [:new]
  resources :users, only: [:show]
end
