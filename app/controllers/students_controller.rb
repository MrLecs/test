class StudentsController < ApplicationController
  before_action :authenticate_student!
  
  layout 'students'
  
  def testing
  end
end