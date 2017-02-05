Rails.application.routes.draw do
  
  resources :pnrs, param: :rcrd_loc
  
  get 'pnrs/index' => 'pnrs#new'
  
  root to: 'pnrs#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
