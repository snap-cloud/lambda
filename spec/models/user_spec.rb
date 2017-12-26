# == Schema Information
#
# Table name: users
#
#  id                               :integer          not null, primary key
#  provider                         :string
#  uid                              :string
#  name                             :string
#  image_url                        :string
#  url                              :string
#  email                            :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  admin                            :boolean          default(FALSE)
#  lti_user_id                      :string
#  lis_person_contact_email_primary :string
#  lis_person_name_family           :string
#  lis_person_name_full             :string
#  lis_person_name_given            :string
#  lis_person_sourcedid             :string
#  user_image                       :string
#  roles                            :string           default([]), is an Array
#
# Indexes
#
#  index_users_on_lti_user_id  (lti_user_id) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
