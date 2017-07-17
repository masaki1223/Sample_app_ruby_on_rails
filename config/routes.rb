Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

 root 'static_pages#home'
  get '/home', to:'static_pages#home' #equivalent to root

  get '/help', to:'static_pages#help'#, as:'helf'

  get '/about', to:'static_pages#about'

  get '/contact', to:'static_pages#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  resources:users
end
