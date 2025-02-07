# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :quizzes do
    resources :questions
  end

  authenticated :user do
    root to: 'dashboard#show', as: :user_root
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  devise_for :users,
    path: '',
    controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
    },
    path_names: {
      sign_in: 'login',
      password: 'forgot',
      confirmation: 'confirm',
      sign_up: 'sign_up',
      sign_out: 'signout'
    }

  resources :aircrafts
  resource :example, constraints: -> { Rails.env.development? }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "devise/sessions#new"
end
