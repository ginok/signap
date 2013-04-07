Signap::Engine.routes.draw do
  resources :users
  resource :session

  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'
end
