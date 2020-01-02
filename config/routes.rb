Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  #homepage
  root 'homepage#index'
  #careers
  get 'career', to: 'dashboard#career', as: :career
  #legal
  get 'legal', to: 'dashboard#legal', as: :legal
  #language
  get 'language', to: 'dashboard#language', as: :language
  #help
  get 'help', to: 'dashboard#help', as: :help

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

  # transfers
  resources :transfers, only: [:index, :show, :create, :new]

  # confirmation letter
  resources :confirmation_letters, only: [:index, :show, :edit, :update]  do 
    collection do 
      post :upgrade
    end
  end
<<<<<<< HEAD
  # invite friends
  resources :invite_friend, only: [:index]
=======

  #market
  resources :markets do 
    member do 
      post :bit
    end
  end
>>>>>>> inside_trade
end
