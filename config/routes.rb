Rails.application.routes.draw do
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :users, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :items, except: %i(index create)

    # 'item_users' resources
    resources :item_users, only: :destroy
    post 'users/:user_id/items/:item_id/item_users', to: 'item_users#create'
    get 'items/:item_id/item_users', to: 'item_users#index'

    post 'users/items', to: 'items#create_with_current_user' 
    get 'users/items', to: 'items#index_with_current_user'
    resources :users do
      resources :items, only: %i(index create)
    end
    
    post 'signup', to: 'users#create'
    
    resources :payments, only: %i( create update destroy)
  end

  post 'auth/login', to: 'authentication#authenticate'
end
