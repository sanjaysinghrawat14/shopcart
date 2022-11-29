Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
      post '/api-keys', to: 'api_keys#create'
      delete '/api-keys', to: 'api_keys#destroy'
      get '/api-keys', to: 'api_keys#index'
      # put '/user_edit',to: 'api_keys#user_edit'
      put '/user_edit/:id',to: 'tests#user_edit'

    end
  end

  resources :payment_notifications
  resources :order2s
  get '/express', to: 'order2s#express'
  
  # get '/user_feedbacks/new', to: "user_feedbacks#new"
  # post '/user_feedbacks', to: "user_feedbacks#create"
  resources :user_feed_backs
  post '/rate' => 'rater#create', :as => 'rate'
  # get 'emails/unsubscribe'
  
 get '/orders', to: 'orders#index'
 post '/orders/submit', to: "orders#submit"


  resources :projects do
    resources :tasks
  end

  get 'checkout', to: "checkout#index"

  resources :cart_items
  resources :carts
  resources :posts
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    namespace :admin do
      # resources :cars
      resources :users
      resources :categories
      resources :products
      root to: "users#index"
      
    end
    resources :products

    match "users/unsubscribe/:unsubscribe_hash" => "emails#unsubscribe", as: "unsubscribe", via: :all



    get "subcategories" , to: "products#subcategories"

   resources :cars

  #  devise_for :users, path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # },
  # controllers: {
  #   sessions: 'sessions',
  #   registrations: 'registrations'
  # }


  devise_for :users, :controllers => {:sessions => 'sessions', registrations: 'registrations'}
  root 'home#index'
  post "address/new" , to: "checkout#create"
  post "place_order" , to: "checkout#place_order"
  get "checkout/place_order" , to: "checkout#place_order_new"
  post "cart_items/quantity_update" , to: "cart_items#quantity_update"

  # delete "address/destroy/:id" , to: "checkout#destroy"
  delete "address/destroy/:id" , to: "checkout#destroy", as: "address_destroy"
  # resources :addresses
  # scope module: 'admin', path: 'fu' do
  #   resources :users
  # end
end
