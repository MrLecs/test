class RemoveTimeoutAndMarkFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :timeout
    remove_column :questions, :mark
  end
end
