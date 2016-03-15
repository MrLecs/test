Rails.application.routes.draw do
  
  namespace :master do
    root to: 'groups#index'
    
    resources :groups
    resources :students
  end
  
end
