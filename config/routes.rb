Rails.application.routes.draw do
  #get 'uploads/index'
  resources :uploads do
    collection do
      get 'delete_class_year'
    end
  end
  post 'uploads/import'
  #resources :uploads do
  #  collection { post :import }
  #end

  resources :visualizations
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users
  resources :valid_emails
  root 'visualizations#index'

end
