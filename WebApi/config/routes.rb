Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create, :index, :show ]
  
  resources :stories, only: [ :index, :show ] do
    resources :tags, only: [ :index ]
  end
  
  resources :tags, only: [ :index, :show ] do
    resources :stories, only: [ :index ]
  end
  
end
