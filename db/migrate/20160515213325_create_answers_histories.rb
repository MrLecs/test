class CreateAnswersHistories < ActiveRecord::Migration
  def change
    create_table :answers_histories do |t|
      t.references :answer
      t.references :history
    end
  end
end
