class UpdateUserIdOnSubmissions < ActiveRecord::Migration
  def change
    Submission.where(user_id: nil).where.not(dce_lti_user_id: nil).find_each do |subm|
        lti_user = DceLti::User.find_by(id: subm.dce_lti_user_id)
        user = User.find_by(lti_user_id: lti_user.id)
        subm.user_id = user.id
        subm.save!
    end
  end
end
