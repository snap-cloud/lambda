# Set LTI user ids based on Student's full names
Submission.find_each do |subm|
  name = subm.user_info['full_name']
  next unless name
  lti_user = DceLti::User.where(lis_person_name_full: name)
  if lti_user.count != 1
    puts "Found #{lti_user.count} users for #{name}"
    next
  end
  lti_user = lti_user.first
  subm.dce_lti_user_id = lti_user.id
  subm.save!
end