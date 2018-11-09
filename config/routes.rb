Rails.application.routes.draw do
  resources :films, only: %i(create index)
end
