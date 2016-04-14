class User < ActiveRecord::Base
  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    # user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    # user.url = auth_hash['info']['urls']['Twitter']
    user.save!
    user
  end
end
