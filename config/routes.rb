Rails.application.routes.draw do
  resources :user
  resources :shift
  resources :chat
  
  get "up" => "rails/health#show", as: :rails_health_check
  get 'shift/index'
  root 'shift#index'
end
