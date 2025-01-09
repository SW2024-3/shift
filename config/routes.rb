Rails.application.routes.draw do
  resources :user, except: :show
  resources :shift
  resources :chats
  
  namespace :admin do
    resources :user do
      collection do
        post :update_copy
        get 'share/:year/:month', to: 'user#share', as: :share
      end
      member do
        get :shift_edit
      end
    end
    resources :chats
  end
  
  get 'user/users', to: 'user#show_users'
  get 'top/main'
  post 'top/login'
  get 'top/logout'
  
  root 'top#main'
end
