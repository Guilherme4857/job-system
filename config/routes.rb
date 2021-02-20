Rails.application.routes.draw do
  root to: 'home#index'
  resources :jobs, only: %i[index show]

  namespace 'employees' do
    root to: 'home#index'
    resources :companies, only: %i[show new create] do
      resources :jobs, only: %i[index create new show destroy]    
    end
    resources :jobs, only: %i[edit update]
  end
  devise_for :employees, controllers: {registrations: 'employees/registrations'}
end