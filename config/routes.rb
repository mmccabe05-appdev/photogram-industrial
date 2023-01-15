Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  # resources :users, only: :show  # get "/users/:id" => "users#show", as: :user
  get ":username/liked" => "photos#liked", as: :liked_photos

  get ":username" => "users#show", as: :user
  # must stay at the end, very general much problems if higher


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
