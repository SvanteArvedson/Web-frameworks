Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create, :index, :show ] do
    resources :stories, only: [ :index ]
  end
  
  resources :stories, only: [ :index, :show ] do
    resources :tags, only: [ :index ]
    resources :creators, only: [ :index ]
  end
  
  resources :tags, only: [ :index, :show ] do
    resources :stories, only: [ :index ]
  end
  
  get '/search' => 'stories#search'
  
end
