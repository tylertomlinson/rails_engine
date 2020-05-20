Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit]
      resources :merchants, except: [:new, :edit]
      
      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
      end
    end
  end
end
