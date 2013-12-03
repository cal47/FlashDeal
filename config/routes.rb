FlashDeals::Application.routes.draw do
  get "user/create"
  get "user/show"
  get "user/edit"
  get "deals/nearby" => 'deals#nearby'
  resources :deals
 

  devise_for :users, :controllers => {:registrations => "registrations"}

  root :to => "deals#index"

  
end
