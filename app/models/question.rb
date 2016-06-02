class Question < ActiveRecord::Base
  belongs_to :testing
  has_many :answers
  
  belongs_to :parent_question, class_name: 'Question'
  has_many   :sub_questions, foreign_key: 'parent_question_id', class_name: 'Question'
  
  mount_uploader :image, ImageUploader
  
  def short_content
    content.truncate(50)
  end
end
