Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks

  resources :users, only: %i[new create show edit update]

  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :users
  end
end