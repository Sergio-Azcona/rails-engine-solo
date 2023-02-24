Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: :index, controller: :item_merchant
      end

      resources :merchants, only: [:index, :show] do  
        resources :items, only: :index, controller: :merchants_items
      end
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all 
  #* = wildcard ->send to the controller#action
end
