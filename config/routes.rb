Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :readers

  resources :articles do
    member do
      put "like" => "articles#vote"
    end
  end 

  get "history" => "articles#history"
  
  root 'articles#index'

end
