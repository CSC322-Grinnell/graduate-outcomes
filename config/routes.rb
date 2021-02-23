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
  #get 'visualization/index'
  #get 'visualization/show'
  #get 'visualization/new'
  resources :visualizations do
    collection do
      get 'delete_visualization'
    end
end 
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'
root   'sessions#new'
end
