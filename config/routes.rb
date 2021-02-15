Rails.application.routes.draw do
  root to: 'home#index'
  resources :jobs

  devise_for :employees
end
