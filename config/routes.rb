Rails.application.routes.draw do
  get 'users/new'

 root 'static_pages#home'
  get '/home', to:'static_pages#home' #equivalent to root

  get '/help', to:'static_pages#help'#, as:'helf'

  get '/about', to:'static_pages#about'

  get '/contact', to:'static_pages#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  resources:users
end
