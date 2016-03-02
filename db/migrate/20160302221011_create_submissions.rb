class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :question_id
      t.float :score
      t.string :code_submission
      t.string :test_results
      t.json :user_info
      t.integer :session_id

      t.timestamps null: false
    end
  end
end
