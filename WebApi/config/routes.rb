Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create ]
  
  resources :stories, only: [ :show, :index ]
  
  resources :tags, only: [ :show, :index ]
  
end
