Rails.application.routes.draw do

  root to: 'students#index'
  
  # get '/students/start',   to: 'students#start',   as: 'start'
  # get '/students/question', to: 'students#question', as: 'question'
  # get '/students/finish',  to: 'students#finish',  as: 'finish'
  
  get '/students/:action', to: 'students', constraints: {
    action: /start|question|answer|finish/
    }, as: :testing

  devise_for :students,
             :controllers => { :registrations => "devise/custom/registrations" }
               

  namespace :master do
    root to: 'groups#index'
    
    resources :groups
    
    resources :students do
      collection do
        get 'generate_passwords'
      end
    end
    
    resources :answers
    resources :questions
    resources :testings do
      member do
        get 'questions'
      end
    end
    
    resources :histories
  end
  
end
