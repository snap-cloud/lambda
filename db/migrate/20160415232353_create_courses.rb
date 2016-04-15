class CreateCourses < ActiveRecord::Migration
  def change
    # Required the first time we use an hstore column
    enable_extension "hstore"
    
    create_table :courses do |t|
      t.string :name
      t.string :url
      t.string :consumer_key
      t.string :consumer_secret
      t.hstore :configuration

      t.timestamps null: false
    end
    add_index :courses, :name, :unique => true
  end
end
