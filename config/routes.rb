Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  # resources :users, only: :show  # get "/users/:id" => "users#show", as: :user
  # removed above because it conflicted with bottom row (/:username) config

  get ":username/liked" => "photos#liked", as: :liked_photos
  get ":username/feed" => "photos#feed", as: :feed_photos
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#following", as: :following

  get ":username" => "users#show", as: :user
  # must stay at the end, very general much problems if higher


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
