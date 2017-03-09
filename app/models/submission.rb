# == Schema Information
#
# Table name: submissions
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  score           :float
#  code_submission :string
#  test_results    :string
#  user_info       :json
#  session_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  dce_lti_user_id :integer
#
# Indexes
#
#  index_submissions_on_dce_lti_user_id  (dce_lti_user_id)
#  index_submissions_on_user_id          (user_id)
#

class Submission < ActiveRecord::Base
  # belongs_to :user
end
