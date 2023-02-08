Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resource :merchant, only: :show, controller: :item_merchants
      end
    end
  end

  # get '/api/v1/merchants', to: 'merchants#index'

  namespace :api do
    namespace :v1 do
      resources :merchant, only: [:index, :show] do  
        resource :items, only: :show, controller: :merchant_items
      end
    end
  end

end
