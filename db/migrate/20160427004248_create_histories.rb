class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :student, index: true
      t.references :testing, index: true
      t.references :answer, index: true
      t.string :action

      t.timestamps null: false
    end
    add_foreign_key :histories, :students
    add_foreign_key :histories, :testings
    add_foreign_key :histories, :answers
  end
end
