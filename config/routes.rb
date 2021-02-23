Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :users, except: %i(new edit)
      resources :sessions, only: %i(create destroy)
    end
  end
end
