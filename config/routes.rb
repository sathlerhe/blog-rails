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

  get '/articles', to: 'article#index'
  get '/articles/:id', to: 'article#show'
  post '/articles', to: 'article#create'
end
