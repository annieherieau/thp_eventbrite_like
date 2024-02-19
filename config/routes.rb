Rails.application.routes.draw do
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "events#index"

  resources :events
  resources :users
  resources :attendances

  # SESSIONS
  resources :sessions, only: [:new, :create, :destroy]
  get 'sessions/:id', to: 'sessions#destroy'
  

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
