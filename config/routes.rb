Rails.application.routes.draw do
  get 'upload/index'
  get 'upload/import'
  #resources :uploads do
  #  collection { post :import }
  #end
  get 'visualization/index'
  get 'visualization/show'
  get 'visualization/new'
  # TODO resources :visualization
  root 'visualization#index'
end
