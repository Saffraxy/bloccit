Rails.application.routes.draw do

  resources :advertisement

  get 'advertisement/' => 'advertisement#index'
  get 'advertisement/:id' => 'advertisement#show'

  #get 'advertisement/index'

  #get 'advertisement/show'

  #get 'advertisement/new'

  #get 'advertisement/create'

  resources :posts

  get 'about' => 'welcome#about'

  #get 'welcome/faq'

  root 'welcome#index'

end
