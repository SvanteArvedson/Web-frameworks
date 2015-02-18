Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create, :index, :show ]
  
  resources :stories, only: [ :index, :show ]
  
  resources :tags, only: [ :index, :show ]
  
end
