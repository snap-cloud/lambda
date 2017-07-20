class UpdateUserIdOnSubmissions < ActiveRecord::Migration
  def change
    Submission.where(user_id: nil).where.not(
      dce_lti_user_id: nil).find_each do |submission|
        lti_user = DceLti::User.find(submission.dce_lti_user_id)
        user = User.find_by(lti_user_id: lti_user.lti_user_id)
        submission.user_id = user.id
        submission.save!
    end
  end
end
