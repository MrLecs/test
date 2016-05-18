class CreateTestSuites < ActiveRecord::Migration
  def change
    create_table :test_suites do |t|
      t.references :student, index: true
      t.references :testing, index: true
      t.timestamp :started_at
      t.timestamp :finished_at

      t.timestamps null: false
    end
    add_foreign_key :test_suites, :students
    add_foreign_key :test_suites, :testings
  end
end
