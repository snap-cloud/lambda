Rails.application.routes.draw do
  
  root :to => "problems#index"
  
  resources :problems do
    member do
      # TODO: Figure out if a submissions controller might be better...
      post 'submission', to: 'problems#submit_grade'
      get 'starter-file', to: 'problems#starter_file'
      get 'test-file', to: 'problems#test_file'
    end
  end

  get 'welcome/index'

  mount DceLti::Engine => '/lti'

  # Public Redirects
  get 'snap', to: 'welcome#snap'
end
