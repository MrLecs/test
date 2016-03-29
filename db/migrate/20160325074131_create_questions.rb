class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :testing, index: true
      t.text :content
      t.integer :timeout
      t.integer :mark

      t.timestamps null: false
    end
    add_foreign_key :questions, :testings
  end
end
