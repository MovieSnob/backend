# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api' do
    mount ActionCable.server => '/cable'

    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'authentication#register'

    resources :users, only: %i[index] do
      collection do
        get 'me'
      end
    end

    resources :films, only: %i[create index destroy] do
      collection do
        get 'suggested'
        get 'reviewed'
      end

      member do
        post 'watched', to: 'films#mark_watched'
        post 'unwatched', to: 'films#mark_unwatched'
        patch 'score'
      end
    end

    resources :stats, only: %(index)
  end
end
