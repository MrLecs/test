class History < ActiveRecord::Base
  belongs_to :student
  belongs_to :testing
  belongs_to :answer
end
