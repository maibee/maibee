Rails.application.routes.draw do
  get 'wallets/show'
  # 首頁
  root 'dashboard#index'

  # 錢包頁面 User wallet path
  get 'wallet', to: 'wallets#show', as: :wallet
  
end
