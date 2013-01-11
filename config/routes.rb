ExamPortal::Application.routes.draw do

  resources :answers
  resources :exams

  scope 'admin' do
    resources :technologies do
      resources :topics do
        resources :questions do
          collection do
            get "list_option_type"
          end
        end
      end
    end
    resources :topics
    resources :questions do
      collection do
        get "list_option_type"
      end
    end
    resources :reports
    resources :departments
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  match '/exam/:id'  => 'home#exam', :as => :exam
  match '/save_exam/:id' => 'home#save_exam', :as => :save_exam
  match '/reports/:id/exam' => 'reports#show', :as => :show_reports
  match '/check_free_text_answers/:id' => 'home#check_free_text_answers', :as => :free_text_answers
  match 'my_reports'  => 'reports#my_reports', :as => :my_reports
  match 'search'  => 'reports#search', :as => :search
end