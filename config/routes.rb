Rails.application.routes.draw do
  get 'upload/index'
  post 'upload/import'
  #resources :uploads do
  #  collection { post :import }
  #end
  #get 'visualization/index'
  #get 'visualization/show'
  #get 'visualization/new'
  resources :visualizations
  # TODO resources :visualization
  root 'visualizations#index'
end
