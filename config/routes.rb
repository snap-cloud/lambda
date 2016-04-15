Rails.application.routes.draw do

  resources :courses
  root :to => "questions#index"

  resources :questions do
    member do
      # TODO: Figure out if a submissions controller might be better...
      post 'submission', to: 'questions#submit_grade'
      get 'starter-file', to: 'questions#starter_file'
      get 'test-file', to: 'questions#test_file'
    end
  end

  # Oauth Account URLs
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'welcome/index'

  mount DceLti::Engine => '/lti'

  # Public Redirects
  get 'snap', to: 'welcome#snap'
end
