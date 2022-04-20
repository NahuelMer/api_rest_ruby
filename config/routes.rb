Rails.application.routes.draw do
  
  resources :clients, only: [:show, :index, :update, :destroy, :create]

end
