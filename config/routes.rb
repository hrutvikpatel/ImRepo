Rails.application.routes.draw do
  root to: redirect('/images')

  devise_for :users
  devise_for :admins

  resources :users do 
    resource :account, :controller => 'account', only: [:show, :update]
    resources :orders, only: [:index]
  end
  
  resources :products, :path => :images, only: [:index, :show]
  resources :categories, only: [:index, :show]

  namespace :admin do
    root to: redirect('/images')
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
