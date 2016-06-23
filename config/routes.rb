Rails.application.routes.draw do

  namespace :admin do
    resources :teams do
      resources :users, controller: :team_memberships
      resources :skills, controller: :team_skills
    end
    resources :users do 
      resources :teams, controller: :user_memberships
    end
    resources :skills do
      get :autocomplete_skill_context, :on => :collection
    end
  end

  resources :skills do
    resources :claims
    get 'recent', on: :collection
    get 'recommended', on: :collection
    get 'your', on: :collection
  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  # avoid annoying message
  # https://github.com/plataformatec/devise/wiki/How-To:-Require-authentication-for-all-pages
  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
