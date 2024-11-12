Rails.application.routes.draw do
  resources :user, except: :show
  resources :shift
  resources :chats
  
  get 'user/users', to: 'user#show_users'
  get 'top/main'
  post 'top/login'
  get 'top/logout'
  
  root 'top#main'
end
