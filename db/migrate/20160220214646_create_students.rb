class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
