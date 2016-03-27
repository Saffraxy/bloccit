Rails.application.routes.draw do

  resources :topics do
      resources :posts, except: [:index]
      resources :sponsoredposts, except: [:index]
  end


  get 'about' => 'welcome#about'

  #get 'welcome/faq'

  root 'welcome#index'

end
