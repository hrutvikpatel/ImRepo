Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
  end
  root to: redirect('/images')

  devise_for :users
  devise_for :admins

  resources :users do 
    resource :account, :controller => 'account', only: [:show, :update]
    resources :orders, only: [:index, :create]
  end
  
  resources :products, :path => :images, only: [:index, :show]
  resources :categories, only: [:index, :show]

  namespace :admin do
    root to: redirect('/images')
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :orders, only: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
