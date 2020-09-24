Rails.application.routes.draw do
  get 'upload/index'
  get 'visualization/index'
  get 'visualization/show'
  get 'visualization/new'
  get 'visualization/create'
  root 'visualization#index'
end
