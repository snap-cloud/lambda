Rails.application.routes.draw do
  root :to => "problems#index"
  resources :problems
  #get 'problem/new'

  get 'welcome/index'

  mount DceLti::Engine => "/lti"

  # Public Redirects
  get 'snap', to: 'welcome#snap'
end
