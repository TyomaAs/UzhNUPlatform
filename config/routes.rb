Rails.application.routes.draw do
  root 'main#index', as: 'home'

  # get 'login' => 'main#login', as: 'login'


  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

  resources :users, only: [:index, :edit, :update, :destroy, :new, :create, :show]
  resources :courses do
    resources :posts do
      resources :comments, only: [:create]
    end
    resources :tasks
  end
end
