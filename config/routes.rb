require 'api_constraints'

Rails.application.routes.draw do
  get 'test_cases/destroy'

  # Api definition
  namespace :api, defaults: { format: :json } do
    # We are going to list our resources here
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]

      resources :challenges, only: [] do
        resources :submits, only: [:create]
      end
      namespace :worker do
        resources :challenges, :only => [:show] do
          resources :submits, :only => [:show] do
            resources :code_results, :only => [:show, :create]
          end
        end
        resource :evaluators, :only => [:show]
      end
    end
  end
  devise_for :users
  resources :challenges
  resources :test_cases, only: [:destroy]
  root 'challenges#index'

end
