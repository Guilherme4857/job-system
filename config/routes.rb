Rails.application.routes.draw do
  root to: 'home#index'
  resources :jobs, only: %i[index show]
  resources :companies, only: %i[new create]
  resources :company_addresses, only: %i[create]

  namespace 'employees' do
    resources :jobs
  end
  
  devise_for :employees, controllers: {registrations: 'employees/registrations'}
end
