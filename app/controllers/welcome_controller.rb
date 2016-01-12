class WelcomeController < ApplicationController
  def index
  end

  def snap
    puts 'GET SNAP'
    redirect_to '/snap/'
  end
end
