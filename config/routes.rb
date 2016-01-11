Rails.application.routes.draw do
  root "home#index"

  resources :playlists, only: [:new]
end
