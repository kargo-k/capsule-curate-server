Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :items
      resources :capsules
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      delete '/profile', to: 'users#destroy'
      patch '/capsules/activate/:id', to: 'capsules#activate'
    end
  end

end
