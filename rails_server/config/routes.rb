Rails.application.routes.draw do
  resources :accounts, only: [:index]
  resources :assignments, :as => :tyto_assignments
  resources :classrooms
  resources :courses
  resources :dashboards, only: [:index]
  resources :invites, only: [:create, :index, :update]
  resources :questions
  resources :sessions, only: [:new, :create, :destroy]
  resources :students, :teachers

  root 'static_pages#home'

  post '/students', to: 'students#create'

  match '/teachersignup', to: 'teachers#new', via: 'get'

  match '/studentsignup', to: 'students#new', via: 'get'

  match '/signin', to: 'sessions#new', via: 'get'
  match '/:user_type/signin', to: 'sessions#new', via: 'get'

  match '/signout', to: 'sessions#destroy', via: 'delete'

  post '/assignments/create' => 'assignments#create'
  post '/classrooms/create' => 'classrooms#create'
  post '/responses/create' => 'responses#create'
  post '/classrooms/update' => 'classrooms#update'
  post '/chapters/index' => 'chapters#index'
  post '/classrooms/text' => 'classrooms#update_text'
  post '/messages/index' => 'messages#index'
  post '/messages/create' => 'messages#create'
  post '/classrooms/accepted' => 'classrooms#accepted'
end
