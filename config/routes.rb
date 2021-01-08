Rails.application.routes.draw do
  namespace :admin do
    get 'images/index'
    get 'images/new'
    get 'images/create'
    get 'images/edit'
    get 'images/update'
    get 'images/destroy'
  end
  root to: 'images#index'

  devise_for :admins
  devise_for :users

  resources :images, only: [:index, :show]
  resources :categories, only: [:show]

  namespace :admin do
    root to: 'product#index'
    resources :images, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
