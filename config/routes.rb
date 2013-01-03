ExamPortal::Application.routes.draw do

  resources :exams


  scope 'admin' do
    resources :technologies do
      resources :topics
    end
    resources :topics
    resources :questions do
      collection do
        get "list_option_type"
      end
    end
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  match '/exam/:id'  => 'home#exam', :as => :exam
  match '/save_exam/:id' => 'home#save_exam', :as => :save_exam
end