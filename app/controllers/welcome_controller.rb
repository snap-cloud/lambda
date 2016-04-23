class WelcomeController < ApplicationController
  def index
  end

  def snap
    redirect_to '/snap/'
  end
end
