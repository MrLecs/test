class StudentsController < ApplicationController
  before_action :authenticate_student!
  before_action :set_question, only: [:question, :answer]
  
  layout 'students'
  
  def index
    @testings = Testing.all
  end
  
  def start
    testing = Testing.find(params[:testing_id].to_i)
    
    cookies['tid'] = testing.id
    cookies['title'] = testing.title
    cookies['questions'] = testing.questions.map(&:id).shuffle.to_json
    cookies['idx'] = 0
    
    History.create(student: current_student, testing: testing, action: :start)
    
    redirect_to testing_path(:question)
  end
  
  def question
  end
  
  def answer
    # Ответов может быть несколько! Надо перегенерить модель History
    
    if @idx + 1 < @questions.size
      cookies['idx'] = @idx + 1
      redirect_to testing_path(:question)
    else
      redirect_to testing_path(:finish)
    end
  end
  
  def finish
    testing = Testing.find(cookies['tid'].to_i)
    
    History.create(student: current_student, testing: testing, action: :finish)
    
    cookies['tid'] = nil
  end
  
  private
  
  def set_question
    @idx = cookies['idx'].to_i
    @questions = JSON.parse(cookies['questions'])
    @question = Question.find(@questions[@idx])
  end
end