Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register', to: 'registrations#create'
      post '/login', to: 'sessions#create'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
