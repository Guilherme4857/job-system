Rails.application.routes.draw do
  root to: 'home#index'

  get 'search', to: 'home#search'
               
  resources :companies, only: %i[show]

  resources :jobs, only: %i[index show] do
    post 'apply_to', on: :member
    post 'unapply_to', on: :member
  end

  devise_for :job_seekers
  resources :job_seekers, only: %i[edit show update] do
    post 'profile_pictures', on: :member  
    get 'new_profile_picture', on: :member
    get 'edit_profile_picture', on: :member
    patch 'profile_picture', on: :member
    delete 'destroy_profile_picture', on: :member
  end

  devise_for :employees, controllers: {sessions: 'employees/sessions'}
  namespace 'employees' do
    root to: 'home#index'
    resources :companies, only: %i[show new create] do
      resources :job_seekers, only: %i[index]
      resources :jobs, only: %i[index create new show] do
        resources :job_seekers, only: %i[show]
      end    
    end
    resources :jobs, only: %i[edit update destroy] do
      post 'job_disable', on: :member
      post 'job_enable', on: :member
    end
  end
end