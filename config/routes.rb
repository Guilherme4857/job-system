Rails.application.routes.draw do
  root to: 'home#index'
  resources :jobs, only: %i[index create new show]
end
