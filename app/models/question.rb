class Question < ActiveRecord::Base
  belongs_to :testing
  has_many :answers
  
  mount_uploader :image, ImageUploader
end
