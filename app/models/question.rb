class Question < ActiveRecord::Base
  # Make an LTI call that tries to return the previous score.
  def get_previous_score(provider)
    score = nil
    begin
      response = provider.post_read_result!
      if response.successful?
        puts "'Got previous score #{response.score}"
      else
        puts 'Unable to get Previous score'
      end
    rescue Exception => e
      puts 'EXCEPTION IN GETTING PREVIOUS SCORE'
      puts e.message
      puts e.backtrace.inspect
    end
    score
  end
end
