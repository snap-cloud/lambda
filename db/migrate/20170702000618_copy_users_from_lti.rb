class CopyUsersFromLti < ActiveRecord::Migration
  TOOL_PROVIDER_ATTRIBUTES = %i|
    roles
    lis_person_contact_email_primary
    lis_person_name_family
    lis_person_name_full
    lis_person_name_given
    lis_person_sourcedid
    user_image
  |
  def change
    DceLti::User.find_each do |lti_user|
      user = User.find_by_email(lti_user.lis_person_contact_email_primary)
      user ||= User.create
      # Yes, these are stored twice. This will be fixed later.
      user.email = lti_user.lis_person_contact_email_primary
      user.name ||= lti_user.lis_person_name_full
      TOOL_PROVIDER_ATTRIBUTES.each do |attribute|
        user.send("#{attribute}=", lti_user.send(attribute))
      end
      user.save!
    end
  end
end
