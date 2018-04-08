Rails.application.routes.draw do
  
  # READER ROUTES  

  devise_for :readers

  resources :articles do
    member do
      put "like" => "articles#vote"
    end
  end 

  get "history" => "articles#history"
  get "friends" => "articles#friends"

  # ADMIN ROUTES

  devise_for :admins

  resources :statistics

  get "users" => "statistics#users"
  
  # ROOT PATH

  root 'articles#index'

end
