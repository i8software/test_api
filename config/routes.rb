require 'api_constraints'

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  use_doorkeeper scope: 'api/oauth'
  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }, skip: [:sessions, :password]
      resources :geo_caches do
        resources :comments, except: [:index]
        get '/reactions' => 'reactions#index'
        post '/like' => 'reactions#like', as: :like
        post '/unlike' => 'reactions#unlike', as: :unlike
      end

      resources :comments, only: [] do
        resources :replies, except: [:index]
        get '/reactions' => 'reactions#index'
        post '/like' => 'reactions#like', as: :like
        post '/unlike' => 'reactions#unlike', as: :unlike
      end

      resources :replies, only: [] do
        get '/reactions' => 'reactions#index'
        post '/like' => 'reactions#like', as: :like
        post '/unlike' => 'reactions#unlike', as: :unlike
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
