class AddLtiDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lti_user_id, :string
    add_column :users, :lis_person_contact_email_primary, :string, size: 1.kilobyte
    add_column :users, :lis_person_name_family, :string, size: 1.kilobyte
    add_column :users, :lis_person_name_full, :string, size: 1.kilobyte
    add_column :users, :lis_person_name_given, :string, size: 1.kilobyte
    add_column :users, :lis_person_sourcedid, :string, size: 1.kilobyte
    add_column :users, :user_image, :string, size: 1.kilobyte
    add_column :users, :roles, :string, default: [], array: true    
  end
end
