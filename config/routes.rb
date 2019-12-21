Rails.application.routes.draw do

  get 'orders/show'
  # devise
  devise_for :users
  get 'dashboard/index'
  
  # wallet
  resources :wallets, only: [:index]
  # exchange
  resources :exchanges, only: [:index, :show]
  # order
  resources :orders, only: [:create, :show]
  #notice_records
  resources :records, only: [:update, :show]
  # 首頁
  root 'dashboard#index'

  
end
