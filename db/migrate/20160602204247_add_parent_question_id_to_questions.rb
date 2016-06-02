class AddParentQuestionIdToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :parent_question, index: true
    add_foreign_key :questions, :parent_questions
  end
end
