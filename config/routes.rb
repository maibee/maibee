Rails.application.routes.draw do

  # devise
  devise_for :users
  get 'dashboard/index'
  
  # wallet
  resources :wallets, only: [:index]

  # 首頁
  root 'dashboard#index'

  
end
