Rails.application.routes.draw do
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :users, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users do
      resources :items
    end

    post 'signup', to: 'users#create'
  end

  post 'auth/login', to: 'authentication#authenticate'
end
