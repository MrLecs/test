Rails.application.routes.draw do

  root to: 'students#testing'

  devise_for :students,
             :controllers => { :registrations => "devise/custom/registrations" }
               

  namespace :master do
    root to: 'groups#index'
    
    resources :groups
    resources :students
    resources :answers
    resources :questions
    resources :testings do
      member do
        get 'questions'
      end
    end
  end
  
end
