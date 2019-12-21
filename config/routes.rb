Rails.application.routes.draw do

  get 'orders/show'
  # devise
  devise_for :users
  get 'dashboard/index'
  # users account page
  resources :users, only: [:show]
  
  # wallet
  resources :wallets, only: [:index]
  

  # exchange
  resources :exchanges, only: [:index, :show]
  # order
  resources :orders, only: [:create, :show, :index]

  # 首頁
  root 'dashboard#index'


  
end
