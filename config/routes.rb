ExamPortal::Application.routes.draw do

  scope 'admin' do
    resources :technologies do
      resources :topics
    end
    resources :topics
    resources :questions
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end