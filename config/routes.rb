Rails.application.routes.draw do
  # Root to visualize dashboard
  root 'application#visualize'
  get '/upload', to: 'application#upload'
  get '/create', to: 'application#create'
  get '/visualize', to: 'application#visualize'
end
