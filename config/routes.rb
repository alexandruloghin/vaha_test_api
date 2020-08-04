Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resources :workouts, except: :new do
    member do 
      post :assign_exercises
      post :assign_to_trainees
      post :performances
      get  :perform
      get  :exercises
      get  :trainees
    end
  end

  resources :exercises, only: [:index, :create]

  get  'trainees',         to: 'users#trainees'
  get  'my_workouts',      to: 'users#workouts'
  post 'trainers',         to: 'users#trainers'
  post 'choose_trainers',  to: 'users#choose_trainers'
end
