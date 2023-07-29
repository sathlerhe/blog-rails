Rails.application.routes.draw do
  get '/users', to: 'user#index'
  post '/users', to: 'user#create'

  get '/articles', to: 'article#index'
  post '/articles', to: 'article#create'
end
