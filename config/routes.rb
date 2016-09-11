Rails.application.routes.draw do
  # devise_for :users,controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  devise_for :users,controllers: { sessions: "users/sessions",
                         omniauth_callbacks: 'omniauth_callbacks',
                              registrations: "users/registrations" }

  root 'todo#index'

  resources :projects, except: [:new, :show]
  resources :tasks, except: [:new, :show]
  resources :comments, only: [:create, :update, :destroy] do
    member { post 'file_attach' }
  end
end
