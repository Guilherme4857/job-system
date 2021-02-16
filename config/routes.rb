Rails.application.routes.draw do
  root to: 'home#index'
  resources :jobs
  resources :companies, only: %i[new create]

  devise_for :employees, controllers: {registrations: 'employees/registrations'}
end
