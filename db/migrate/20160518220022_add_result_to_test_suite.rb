class AddResultToTestSuite < ActiveRecord::Migration
  def change
    add_column :test_suites, :result, :integer
  end
end
