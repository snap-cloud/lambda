Rails.application.routes.draw do
  root :to => "problems#index"
  resources :problems
  #get 'problem/new'

  get 'welcome/index'

  mount DceLti::Engine => "/lti"

end
