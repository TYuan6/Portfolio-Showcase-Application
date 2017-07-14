Rails.application.routes.draw do

  resources :videos
  resources :groups
  resources :pictures

  get 'pages/home'
  get 'pages/styles'
  get 'pages/about'
  get 'pages/publicPortfolios'

  get 'portfolios/generateLink/:token' => 'portfolios#generateLink', :as => "generateLink_portfolios"
  get 'myportfolio/groups/:token', :to => 'group_csses#show_group', :as => "myportfolio_group_link"
  get 'myportfolio/groups/project/:token' , :to => 'proj_csses#show_project', :as => "myportfolio_project_link"
  get 'myportfolio/groups/project/show/:token' , :to => 'projs#show_project_show', :as => "myportfolio_project_show_link"
  
  
  resources :portfolios do
    get '/proj_csses/:group_id/edit', to: 'proj_csses#edit', as: 'proj_csses_edit'
    get '/proj_csses/:group_id', to: 'proj_csses#show', as: 'proj_csses_show'
    patch '/proj_csses/:group_id', to: 'proj_csses#update', as: 'proj_csses_update'
    get '/group_csses/edit', to: 'group_csses#edit', as: 'group_csses_edit'
    get '/group_csses', to: 'group_csses#show', as: 'group_csses_show'
    
    
    patch '/group_csses', to: 'group_csses#update', as: 'group_csses_update'
  end
  

  
  
  
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
  root 'pages#home'

  # add by HuiXie
  resources :projs
  # resources :projs do
  #     resources :pictures
  # end

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
