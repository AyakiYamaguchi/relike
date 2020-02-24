require 'sidekiq/web'
Rails.application.routes.draw do
  root 'top#index'
  get 'remind_lists/index'
  get 'remind_lists/show'
  devise_for :users, controllers: {:omniauth_callbacks => "omniauth_callbacks"}
  
  resources :users, :only => [:show]
  resources :remind_lists, :only => [:index, :update, :show] do
    collection do
      get 'remind_counts/:remind_count' , to: 'remind_lists#list_by_count', as: :count
      get ':user_id/:remind_date' , to: 'remind_lists#check_list' , as: :check
      get ':user_id/:remind_date/finish' , to: 'remind_lists#finish' , as: :check_finish
      get 'not_found' , to: 'remind_lists#not_found'
    end
  end

  resources :memos, :only => [:create]
  get 'signup', to: 'users#signup'
  get '/signup/line', to: 'users#signup_line'
  get '/signup/twitter', to: 'users#signup_twitter'
  get '/signup/finish', to: 'users#signup_finish'
  
  post 'push_message' , to: 'remind_lists#push_message'

  mount Sidekiq::Web => '/sidekiq'
end
