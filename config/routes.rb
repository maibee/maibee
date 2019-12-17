Rails.application.routes.draw do

  # devise
  devise_for :users
  get 'dashboard/index'
  
  # wallet
  resource :wallet, only: [:show]

  # exchange
  get ':currency', to: 'exchange#index', as: :exchange
  # get 'exchange/:currency', to: 'exchange#index', as: :exchange
  
  # 首頁
  root 'dashboard#index'

  # 錢包頁面 User wallet path
  # get 'wallet', to: 'wallets#show', as: :wallet
  
end
