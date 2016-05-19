class AddRandomFieldsToTestings < ActiveRecord::Migration
  def change
    add_column :testings, :random_questions, :boolean, default: false
    add_column :testings, :random_answers,   :boolean, default: false
  end
end
