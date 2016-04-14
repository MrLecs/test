class StudentsController < ApplicationController
  before_action :authenticate_student!
  
  layout 'students'
  
  def index
    @testings = Testing.all
  end
  
  def testing
    if params[:testing_id].to_i != 0
      cookies['tid'] = params[:testing_id].to_i
    end    
    
    @testing = Testing.find(cookies['tid'].to_i)
    @question_number = (cookies['qn'] || '1').to_i
    @number_of_questions = @testing.questions.size
    @question = @testing.questions[@question_number - 1]
    
    if @question_number > @number_of_questions
      redirect_to finish_path
    else
      cookies['qn'] = @question_number + 1
    end
  end
  
  def finish
    cookies['qn'] = nil
  end
end