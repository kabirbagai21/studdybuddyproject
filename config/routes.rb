Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "students#index"

  resources :students do
    resources :enrollments
    post 'enroll', on: :member
  end

  resources :courses do
    resources :enrollments
  end

  resources :groups

  #post '/enroll_student', to: 'courses#enroll_student'
  # Defines the root path route ("/")
  # root "posts#index"
end
