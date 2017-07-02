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

class User < ActiveRecord::Base
  has_many :submissions

  # validates :lti_user_id, uniqueness: true, length: { maximum: 255 }

  def roles=(roles)
    super roles.map{|role| role.downcase}
  end

  def has_role?(role)
    roles.include?(role.to_s.downcase)
  end

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(
      uid: auth_hash['uid'],
      provider: auth_hash['provider']
    )
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    # user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    # user.url = auth_hash['info']['urls']['Twitter']
    user.save!
    user
  end
  
  def auth_methods
    methods = []
    methods << 'Google' if provider
    methods << 'LTI' if lti_user_id
    methods.join(', ')
  end
end
