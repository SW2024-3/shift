Rails.application.routes.draw do
  resources :user
  resources :shift
  resources :chats

  get 'shift/index'
  root 'shift#index'
end
