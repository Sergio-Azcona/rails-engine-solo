Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: :show, controller: :item_merchants
      end
    end
  end

  # get '/api/v1/merchants', to: 'merchants#index'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do  
        resources :items, only: :index, controller: :merchants_items
      end
    end
  end

end
