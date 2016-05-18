class AddTestSuiteToHistories < ActiveRecord::Migration
  def change
    add_reference :histories, :test_suite, index: true
    add_foreign_key :histories, :test_suites

    remove_column :histories, :student_id
    remove_column :histories, :testing_id
  end
end
