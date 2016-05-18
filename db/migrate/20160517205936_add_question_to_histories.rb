class AddQuestionToHistories < ActiveRecord::Migration
  def change
    add_reference :histories, :question, index: true
    add_foreign_key :histories, :questions
  end
end
