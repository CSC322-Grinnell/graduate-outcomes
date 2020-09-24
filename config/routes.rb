Rails.application.routes.draw do
  get 'upload/index'
  get 'visualization/index'
  get 'visualization/show'
  get 'visualization/new'
  # TODO resources :visualization
  root 'visualization#index'
end
