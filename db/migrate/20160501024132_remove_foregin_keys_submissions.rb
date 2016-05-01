class RemoveForeginKeysSubmissions < ActiveRecord::Migration
  def change
    remove_foreign_key "submissions", "dce_lti_users"
    remove_foreign_key "submissions", "users"
  end
end
