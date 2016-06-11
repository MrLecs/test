class StudentsController < ApplicationController
  
  #
  # Перед выполнением любого метода котроллера, проверяем аутентификацию
  # пользователя. 
  #
  before_action :authenticate_student!
  
  #
  # Перед выполнением методов, указанных в массиве only, вызываем set_question
  #
  before_action :set_question, only: [:question, :answer, :skip_question]
  
  #
  # Перед выполнением методов, указанных в массиве only, вызываем set_testing
  #
  before_action :set_testing,  only: [:question, :answer, :skip_question, :finish]
  
  layout 'students'
  
  #
  # Выводим список всех тестов
  #
  def index
    @testings = Testing.all
  end
  
  #
  # Стартуем выполнение теста
  #
  def start
    #
    # Выбираем нужный тест
    #
    @testing    = Testing.find(params[:testing_id].to_i)
    
    #
    # Создаем объект класса TestSuite для авторизованного студента и выбранного
    # теста
    #
    @test_suite = TestSuite.start(student: current_student, testing: @testing)

    #
    # Инициализируем Cookies
    #
    init_cookies

    #
    # Перенаправляем пользователя на первый вопрос теста
    #
    redirect_to testing_path(:question)
  end

  #
  # Отрисовка вопроса. Сам объект вопроса уже выбран благодаря before_action 
  #
  def question
  end
  
  #
  # Отмечаем ответ студента на вопрос
  #
  def answer
    @test_suite.answer(question: @question, answers: Answer.find(params['answers'])) rescue nil

    next_question
  end

  #
  # Студент пропускает вопрос. Отмечаем этот факт и переходим к следующему 
  # вопросу
  #
  def skip_question
    @test_suite.skip_question(question: @question)

    next_question
  end
  
  #
  # Окончание теста
  #
  def finish
    @test_suite.finish
    
    clear_cookies
  end
  
  private
  
  #
  # Устанавливаем вопрос на основании Cookies. В Cookies у нас хранится
  # порядковый номер вопроса в построенном списке вопросов. По нему определяется
  # вопрос и достается из базы данных в переменную @question.
  #
  def set_question
    @idx       = cookies['idx'].to_i
    @questions = JSON.parse(cookies['questions'])
    @question  = Question.find(@questions[@idx])
  end

  #
  # Установка переменных @testing и @test_suite
  #
  def set_testing
    @testing    = Testing.find(cookies['tid']) rescue nil
    @test_suite = TestSuite.find(cookies['tsid']) rescue nil
  end

  #
  # Переход к следующему вопросу. В Cookies меняется порядковый номер вопроса
  # (+1). Если вопросы закончились, то редирект на окончание тестирования
  #
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
    cookies['idx']       = 0
    cookies['questions'] = questions_list().to_json
  end

  def clear_cookies
    cookies['tid']  = nil
  end
  
  #
  # Построение списка вопросов. Для начала выбираются те вопросы, которые НЕ
  # являются дополнительными кому-либо. Перемешиваем их, если выбрана
  # соответствующая галочка в настройках теста. Далее по списку вопросов 
  # выгружаются дополнительные.
  #
  def questions_list
    questions = @testing.questions.where(parent_question_id: nil).to_a
    questions.shuffle! if @testing.random_questions?
    
    questions.each_with_index do |question, index|
      question.sub_questions.each_with_index do |sub_question, sub_index|
        questions.insert(index + sub_index + 1, sub_question)
      end
    end
    
    questions.map(&:id)
  end
end