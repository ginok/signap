Signap::Engine.routes.draw do
  resources :users
  resource :session
  resource :confirmation do
    get :about
  end

  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  #get 'confirmation/:confirmation_token' => 'confirmations#show', as: 'confirmation'
  #patch 'confirm' => 'confirmations#confirm', as: 'confirm'
end
