class StudentsController < ApplicationController
  before_action :authenticate_student!
  before_action :set_question, only: [:question, :answer, :skip_question]
  before_action :set_testing,  only: [:answer, :finish, :skip_question]
  
  layout 'students'
  
  def index
    @testings = Testing.all
  end
  
  def start
    @testing    = Testing.find(params[:testing_id].to_i)
    @test_suite = TestSuite.start(student: current_student, testing: @testing)

    init_cookies

    redirect_to testing_path(:question)
  end

  def question
  end
  
  def answer
    @test_suite.answer(question: @question, answers: Answer.find(params['answers']))

    next_question
  end

  def skip_question
    @test_suite.skip_question(question: @question)

    next_question
  end
  
  def finish
    @test_suite.finish
    
    clear_cookies
  end
  
  private
  
  def set_question
    @idx       = cookies['idx'].to_i
    @questions = JSON.parse(cookies['questions'])
    @question  = Question.find(@questions[@idx])
  end

  def set_testing
    @testing    = Testing.find(cookies['tid'])
    @test_suite = TestSuite.find(cookies['tsid'])
  end

  def next_question
    if @idx + 1 < @questions.size
      cookies['idx'] = @idx + 1
      redirect_to testing_path(:question)
    else
      redirect_to testing_path(:finish)
    end
  end

  #
  # Храним все необходимые переменные в Cookies, а не в GET параметрах для
  # того, чтобы у студента не было возможности что-то поправить в URL.
  # Конечно, студент может и в Cookies залезть, но это уже на порядок сложнее
  # и Cookies можно будет зашифровать на крайний случай. Еще вариант хранить 
  # в сессии
  #
  def init_cookies
    cookies['tid']       = @testing.id
    cookies['tsid']      = @test_suite.id
    cookies['title']     = @testing.title
    cookies['questions'] = @testing.questions.map(&:id).shuffle.to_json
    cookies['idx']       = 0
  end

  def clear_cookies
    cookies['tid']  = nil
    cookies['tsid'] = nil
  end
end