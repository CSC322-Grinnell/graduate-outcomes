Rails.application.routes.draw do
  get 'uploads/index'
  post 'uploads/import'
  #resources :uploads do
  #  collection { post :import }
  #end
  #get 'visualization/index'
  #get 'visualization/show'
  #get 'visualization/new'
  resources :visualizations
  root 'visualizations#index'
end
