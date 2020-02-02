Rails.application.routes.draw do
  get 'remind_lists/index'
  get 'remind_lists/show'
  devise_for :users, controllers: {:omniauth_callbacks => "omniauth_callbacks"}
  
  resources :users, :only => [:show]
  resources :remind_lists, :only => [:index, :update, :show]
  resources :memos, :only => [:create]
  get 'signup', to: 'users#signup'
  get '/signup/line', to: 'users#signup_line'
  get '/signup/twitter', to: 'users#signup_twitter'
  get '/signup/finish', to: 'users#signup_finish'
  get '/remind_lists/remind_counts/:remind_count' , to: 'remind_lists#list_by_count'
  get '/remind_lists/:user_id/:remind_date' , to: 'remind_lists#check_list'
  get '/remind_lists/:user_id/:remind_date/finish' , to: 'remind_lists#finish'
  get '/remind_lists/not_found' , to: 'remind_lists#not_found'
  post 'push_message' , to: 'remind_lists#push_message'
end
