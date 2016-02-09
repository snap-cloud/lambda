class SubmissionsController < ApplicationController

  def submit_grade
    puts 'CONTROLLER SUBMIT GRADE'
    puts 'Params: ', params
    puts 'SESSION:  ', ap(session.inspect)

    provider = Rails.application.config.global_tp

    if provider.outcome_service?
      puts 'READY TO SUBMIT GRADE'
    else
      puts 'NO SUBMIT GRADE'
      # normal tool launch without grade write-back
    end

    redirect_to '/', flash[:success] => 'Posted a grade...sorta'

  end
end