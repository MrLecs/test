Rails.application.routes.draw do
  
  namespace :master do
    resources :groups
    resources :students
  end
  
end
