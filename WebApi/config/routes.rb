Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create ]
  
  resources :stories, only: [ :show, :index ]
  
end
