Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :readers

  resources :articles do
    member do
      put "like" => "articles#vote"
    end
  end 
  
  root 'articles#index'

end
