A4ProjectRevive::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root :to => 'pages#index', :as => 'root', :via => :get

  match '/products' => 'products#index', :as => 'products', :via => :get

  match '/products/kick' => 'products#kicks', :as => 'kicks', :via => :get

  match '/products/punch' => 'products#punches', :as => 'punches', :via => :get

  match '/products/block' => 'products#blocks', :as => 'blocks', :via => :get

  match 'products/:id' => 'products#show', :as => 'product', :via => :get

  match '/results' => 'products#results', :as => 'results', :via => :post

  match '/about' => 'pages#about', :as => 'about', :via => :get

  match '/contact' => 'pages#contact', :as => 'contact', :via => :get

  match '/add_to_cart/:id' => 'products#add_to_cart', :as => 'add', :via => :post

  match '/remove_from_cart/:id' => 'products#remove_from_cart', :as => 'remove', :via => :post

  match '/start_checkout' => 'products#start_checkout', :as => 'start_checkout', :via => :get

  match '/finish_checkout' => 'products#finish_checkout', :as => 'finish_checkout', :via => :post

  match '/view_cart' => 'products#view_cart', :as => 'view_cart', :via => :get



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
