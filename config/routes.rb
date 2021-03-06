GoT::Application.routes.draw do
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "oauths/oauth"
  get "oauths/callback"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: 'pages#index'
  resources :gifts, except: [:index]
  get 'gift/find' => 'gifts#find', as: 'find_gift'
  resources :users, except: [:index, :show]
  get 'user/profile' => 'users#profile', as: 'user_profile'
  resources :sessions, only: [:new, :create, :destroy]
  post "oauth/callback" => "oauths#callback"
  patch 'gift/:gift_id/remove_photo' => 'gifts#remove_photo', as: 'remove_photo'
  get 'oauth/callback' => 'oauths#callback'
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  get 'gift/:gift_id/complete' => 'gifts#complete', as: 'complete_gift'
  get 'gift/:gift_id/certificate' => 'gifts#certificate', as: 'certificate'
  get 'gift/:gift_id/checkout' => 'gifts#checkout', as: 'checkout'
  get 'users/admin' => 'users#admin', as: 'admin'
  resources :volunteers, except: [:show]
  get 'admin/update' => 'users#admin_update', as: 'admin_update'
  resources :charges, only: [:create]
  get 'gift/:gift_id/donate' => 'gifts#donate', as: 'donate'
  get 'gift/:gift_id/download' => 'gifts#download', as: 'download'
  resources :password_resets
  resources :prices, only: [:update]
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
