module DceLti
  class ApplicationController < ::ApplicationController
    helper :all
    protect_from_forgery with: :exception
  end
end
