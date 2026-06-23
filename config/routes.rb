Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  resources :labels
  resources :users
  resource :session, only: %i[new create destroy]

  get '/test_login/:id', to: 'sessions#test_login', as: :test_login if Rails.env.test?
end