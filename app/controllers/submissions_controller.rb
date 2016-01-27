class SubmissionsController < ApplicationController

  def submit_grade
    puts 'SUBMIT GRADE'
    puts 'Params: ', params
    puts 'SESSION:  ', session
    redirect_to '/', :flash => 'Posted a grade'
  end
end