Rails.application.routes.draw do
  root "home#index"
  get '/auth/spotify', as: :login
  get '/auth/spotify/callback', to: 'users#spotify'
  resources :playlists, only: [:new]
end
