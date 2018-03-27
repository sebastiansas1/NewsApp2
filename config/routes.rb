Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :readers
  resources :articles
  root 'articles#index'

end
