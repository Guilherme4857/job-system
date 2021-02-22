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
    resources :jobs, only: %i[edit update destroy]
  end
  devise_for :employees, controllers: {
  registrations: 'employees/registrations', 
  sessions: 'employees/sessions'}
  
  devise_for :job_seekers, controllers: {
  sessions: 'job_seeker/sessions'}

  get '/job_seekers/:id', to: 'job_seekers#show', as: 'job_seeker'
end