Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'authentication#register'

  get 'users/me'

  resources :films, only: %i[create index] do
    collection do
      get 'suggested'
    end

    member do
      post 'watched', to: 'films#mark_watched'
      post 'unwatched', to: 'films#mark_unwatched'
    end
  end
end
