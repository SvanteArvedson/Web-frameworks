Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
  resources :creators, only: [ :create ]
  
end
