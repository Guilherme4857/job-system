Rails.application.routes.draw do
  root to: 'home#index'
  get 'search', to: 'home#search'
  resources :jobs, only: %i[index show]
  resources :companies, only: %i[show]

  namespace 'employees' do
    root to: 'home#index'
    resources :companies, only: %i[show new create] do
      resources :jobs, only: %i[index create new show]    
    end
    resources :jobs, only: %i[edit update destroy] do
      post 'job_disable', on: :member
      post 'job_enable', on: :member
    end
  end
  devise_for :employees, controllers: {
  registrations: 'employees/registrations', 
  sessions: 'employees/sessions'}
  
  devise_for :job_seekers

  resources :job_seekers, only: %i[create new edit show update] do
      post 'profile_pictures', on: :member  
      get 'new_profile_picture', on: :member
      get 'edit_profile_picture', on: :member
      patch 'profile_picture', on: :member
      delete 'destroy_profile_picture', on: :member
  end
end