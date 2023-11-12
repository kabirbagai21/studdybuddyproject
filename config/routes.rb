Rails.application.routes.draw do
  get 'public_profiles/show/:id', to: 'public_profiles#show', as: 'public_profile_show'
  devise_for :students
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "students#show"

  resources :students do
    resources :enrollments
    resources :group_members
    resources :group_requests
    post 'enroll', on: :member
  end

  resources :courses do
    resources :enrollments
    resources :groups
    resources :group_requests
  end

  resources :groups do 
    resources :group_members
    resources :group_requests
    resources :public_profiles, only: [:show]
    patch 'leave', on: :member
  end 

  resources :group_requests do
    patch 'approve', on: :member
  end

  resources :public_profiles, only: [:show]
  
  #post '/enroll_student', to: 'courses#enroll_student'
  # Defines the root path route ("/")
  # root "posts#index"
end
