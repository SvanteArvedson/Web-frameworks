Rails.application.routes.draw do

  post '/authenticate' => 'sessions#authenticate'
  
end
