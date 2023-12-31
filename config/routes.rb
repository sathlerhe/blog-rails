Rails.application.routes.draw do
  devise_for :users, path: '/users', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  delete '/users/delete', to: 'user#destroy'
  put '/users/update', to: 'user#update'
  get '/users/:id/articles', to: 'user#user_articles'

  get '/articles', to: 'article#index'
  get '/articles/:id', to: 'article#show'
  post '/articles', to: 'article#create'
  put '/articles/:id', to: 'article#update'
  delete '/articles/:id', to: 'article#destroy'
end
