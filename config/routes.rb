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

  get "statistics/readers/:reader_id" => "statistics#readers", as: 'statistics_reader'
  get "statistics/readers/:reader_id/preferences/:preference_id" => "statistics#preferences", as: 'statistics_reader_preference'
  get "statistics/readers/:reader_id/keywords/:preference_id" => "statistics#keywords", as: 'statistics_reader_keyword'
  
  # ROOT PATH

  root 'articles#index'

end
