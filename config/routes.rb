Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'authentication#register'

  resources :films, only: %i[create index]
end
