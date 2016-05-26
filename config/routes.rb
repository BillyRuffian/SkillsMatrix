Rails.application.routes.draw do
  namespace :admin do
    resources :teams
    resources :users
  end

  resources :skills do
    resources :claims
    get 'recent', on: :collection
  end
  devise_for :users
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
