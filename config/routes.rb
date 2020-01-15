Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  #homepage
  root 'homepage#index'

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
  resources :exchanges, only: [:index, :show] do
    member do
      get :sell
    end
  end
  # order

  #notice_records
  resources :records, only: [] do 
    collection do 
      post :zeroing
    end
  end

  # order
  resources :orders, only: [:create, :show, :index] do
    member do
      post :pay
    end
  end

  # transfers
  resources :transfers, only: [:index, :show, :create, :new]

  # confirmation letter
  resources :confirmation_letters, only: [:index, :show, :edit, :update]  do 
    collection do 
      post :upgrade
    end
  end
  # invite friends
  resources :invite_friend, only: [:index]

  #market
  resources :markets, only: [:index, :new, :edit, :create] do 
    member do 
      post :bit
    end
  end

  #demo special entrance
  get '/demo', to: 'demo#new'

end
