class AddUsersToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :user, index: true, foreign_key: true
    add_reference :submissions, :dce_lti_user, index: true, foreign_key: true
  end
end
