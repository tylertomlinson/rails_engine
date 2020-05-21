Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
      end
      
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :items, except: [:new, :edit]
      resources :merchants, except: [:new, :edit]
    end
  end
end
