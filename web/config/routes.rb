Rails.application.routes.draw do
  resources :students, :teachers
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions
  resources :courses
  resources :chapters
  resources :classrooms
  resources :assignments, :as => :tyto_assignments
  resources :accounts, only: [:index]
  resources :dashboards, only: [:index]

  root 'static_pages#home'

  post '/students', to: 'students#create'

  match '/teachersignup', to: 'teachers#new', via: 'get'

  match '/studentsignup', to: 'students#new', via: 'get'

  match '/signin', to: 'sessions#new', via: 'get'

  match '/signout', to: 'sessions#destroy', via: 'delete'

  post '/assignments/create' => 'assignments#create'
  post '/classrooms/create' => 'classrooms#create'
  post '/responses/create' => 'responses#create'
  post '/classrooms/update' => 'classrooms#update'
end
