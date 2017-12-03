Rails.application.routes.draw do
  get 'itinerary/new'

  get 'itinerary/current'

  resources :profiles
  devise_for :users
  root :to =>'home#index'  
  get 'home/index'
  
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
