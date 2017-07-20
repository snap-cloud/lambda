class IndexUserOnLtiUserId < ActiveRecord::Migration
  def change
    add_index :users, :lti_user_id, unique: true
  end
end
