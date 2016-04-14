class AddTimeoutToTestings < ActiveRecord::Migration
  def change
    add_column :testings, :timeout, :integer
  end
end
