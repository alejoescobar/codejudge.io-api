require 'api_constraints'

Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: { format: :json }, path: '/api' do
    # We are going to list our resources here
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]

      namespace :worker do
        resources :challenges, :only => [:show] do 
          resources :submits, :only => [:show] do
            resources :code_results, :only => [:show, :create]
          end
        end
      end
    end
  end
  devise_for :users
  resources :challenges
  root 'challenges#index'
end
