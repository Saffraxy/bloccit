Rails.application.routes.draw do
  resources :labels, only: [:show]

  resources :topics do
      resources :posts, except: [:index]
  end

##we use only: [] because we don't want to create any /posts/:id routes,
##  just posts/:post_id/comments routes.
  resources :posts, only: [] do
##we only add create and destroy routes for comments. We'll display comments
##  on the posts show view, so we won't need index or new routes. We also
##  won't give users the ability to view individual comments or edit comments,
##  removing the need for show, update, and edit routes.
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

## we create routes for new and create actions.
### The only hash key will prevent Rails from creating unnecessary routes.
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'welcome/faq'

  root 'welcome#index'

end
