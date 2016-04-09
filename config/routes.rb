Rails.application.routes.draw do
  resources :topics do
      resources :posts, except: [:index]
  end
## we create routes for new and create actions.
### The only hash key will prevent Rails from creating unnecessary routes.
  resources :users, only: [:new, :create]

  post 'users/confirmation' => 'users#confirmation'
  get 'about' => 'welcome#about'

  #get 'welcome/faq'

  root 'welcome#index'

end
