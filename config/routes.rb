Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'authentication#register'

  resources :users, only: %i[index] do
    collection do
      get 'me'
    end
  end

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
