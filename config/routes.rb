Rails.application.routes.draw do

  get 'orders/show'
  # devise
  devise_for :users
  #dashboard
  resources :dashboard, only: :index do
    collection do
      get :permit
    end
  end

  # users account page
  resources :users, only: [:show]
  
  # wallet
  resources :wallets, only: [:index]
  

  # exchange
  resources :exchanges, only: [:index, :show]
  # order

  #notice_records
  resources :records, only: [:update, :show]

  # order
  resources :orders, only: [:create, :show, :index] do
    member do
      post :pay
    end
  end

  # 首頁
  root 'dashboard#index'


  
end
