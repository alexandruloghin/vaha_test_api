Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resources :workouts, except: :new do
    member do 
      post :assign_exercises
      post :assign_to_trainees
      get  :perform
      get  :exercises
      get  :trainees
    end

    collection do
      post :overview
    end
  end

  resources :exercises, only: [:index, :create]

  get  'trainees',         to: 'users#trainees'
  post 'trainers',         to: 'users#trainers'
  post 'choose_trainers',  to: 'users#choose_trainers'
end
