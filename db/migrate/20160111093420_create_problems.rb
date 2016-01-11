class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.float :points
      t.text :content
      t.text :tests
      t.text :initial_file
      t.text :metadata
      t.text :tags

      t.timestamps null: false
    end
  end
end
