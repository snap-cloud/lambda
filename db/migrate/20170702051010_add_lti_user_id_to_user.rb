class AddLtiUserIdToUser < ActiveRecord::Migration
  def change
    # Second migration because the first missed lti_user_id
    DceLti::User.find_each do |lti_user|
      user = User.find_by_email(lti_user.lis_person_contact_email_primary)
      user.lti_user_id = lti_user.lti_user_id
      user.save!
    end
  end
end
