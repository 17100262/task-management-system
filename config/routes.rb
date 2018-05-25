Rails.application.routes.draw do
  resources :skills
  resources :shifts
  get 'my_shifts',to: 'shifts#my_shifts',as: :my_shifts
  put 'shift_users/:id/accept_shift', to: 'shifts#accept_shift',as: :accept_shift
  get 'companies/:company_id/make_admin', to: 'users#new',as: :make_admin
  resources :external_locations
  resources :trainings
  resources :departments
  resources :locations
  resources :companies
  devise_for :users
  # ,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#dashboard'
  # get 'admin', to: 'home#admin', as: :admin
  get 'dashboard', to: 'home#dashboard'
  # , as: :admin
  # get 'users/profile/edit', to: 'users#edit_profile', as: :edit_profile
  resources :users
  get 'users/:id/schedule', to: "users#schedule", as: :user_schedule
  # , path: '/users/profile'

end
