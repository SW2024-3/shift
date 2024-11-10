Rails.application.routes.draw do
  resources :user
  resources :shift
  resources :chat

  get 'shift/index'
  root 'shift#index'
end
