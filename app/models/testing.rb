class Testing < ActiveRecord::Base
  has_many :questions
  
  validates_numericality_of :timeout, :greater_than => 0
end
