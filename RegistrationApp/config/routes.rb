Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'users#index'

  resources :users, only: [:create, :destroy, :index, :new, :show] do
    resources :applications, only: [:create, :destroy, :new]
  end
end
