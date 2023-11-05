Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register', to: 'registrations#create'
      post '/login', to: 'sessions#create'
      post '/logout', to: 'sessions#destroy'

      get '/balance', to: 'wallets#balance'
      post '/deposit', to: 'wallets#deposit'
      post '/withdraw', to: 'wallets#withdraw'
      post '/transfer', to: 'wallets#transfer'

      resources :teams do
        get :balance, on: :member
        post :deposit, on: :member
        post :withdraw, on: :member
        post :transfer, on: :member
      end
    end
  end
end
