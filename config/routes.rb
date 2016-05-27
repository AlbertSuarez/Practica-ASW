Rails.application.routes.draw do
  
  get 'sessions/create'

  get 'sessions/destroy'

  get 'comments/:id/new_reply' => 'comments#new_reply'
  
  patch 'users/:id' => 'users#update'
  
  #### votes ####
  post 'submissions/:id/vote' => 'submissions#vote'
  post 'comments/:id/vote' => 'comments#vote'
  post 'replies/:id/vote' => 'replies#vote'
  ###############
  
  get 'ask' => 'submissions#ask'
  get 'threads' => 'comments#threads'
  get 'user_comments' => 'comments#user_comments'
  get 'users/:user/comments' => 'comments#user_comments'
  get 'user_submissions' => 'submissions#user_submissions'
  get 'users/:user/submissions' => 'submissions#user_submissions'
  
  put 'users' => 'users#update_authenticated'
  
  get '/submissions/:id/comments' => 'comments#submission_comments'
  
  ##########authentication stuff---> don't touch!###############
  get 'signin', to: 'sessions#redirecciona'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  ##############################################################
  
  resources :replies
  resources :comments
  resources :submissions
  resources :users
  resources :sessions, only: [:create, :destroy]
  
  root 'submissions#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'application#hello'

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
