ExamPortal::Application.routes.draw do
  scope 'admin' do
    resources :topics
    resources :technologies
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end