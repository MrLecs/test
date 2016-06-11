#
# Контроллер выведен из класса MasterController, в котором определяются 
# специфичные для пространста Master вещи. Например, авторизация пользователя
# через Basic Authentication и laout master.
#
class Master::TestingsController < MasterController
  
  #
  # Перед выполнением методов, указанных в массиве only, выполняется метод
  # set_testing, который устанавливает переменную @testing
  #
  before_action :set_testing, only: [:show, :edit, :update, :destroy, :questions]

  #
  # Выводит все объекты Testing, которые есть в базе
  #
  # GET /testings
  # GET /testings.json
  def index
    #
    # Запрос к модели Testing. SQL-эквивалент: 'SELECT * FROM testings'
    #
    @testings = Testing.all
  end


  #
  # Отображает выбранные объект @testing. Метод пустой, так как ранее через
  # before_action необходимый объект уже был выбран
  #
  # GET /testings/1
  # GET /testings/1.json
  def show
  end

  #
  # Создание нового объекта Testing.
  #
  # GET /testings/new
  def new
    # 
    # Создаем пустой объект, который передается во views
    #
    @testing = Testing.new
  end

  #
  # Редактирование объекта Testing.
  #
  # GET /testings/1/edit
  def edit
  end

  #
  # Сохранение нового объекта в базе данных
  #
  # POST /testings
  # POST /testings.json
  def create
    #
    # Создаем объект на основании переданных из html-формы параметров. Для этого
    # вызывается метод testing_params
    #
    @testing = Testing.new(testing_params)

    #
    # В зависимости от формата запроса - html или json - определяется отрисовка
    #
    respond_to do |format|
      #
      # Сохраняем объект. 
      #
      # В случае если сохранение прошло успешно, метод save
      # вернет true и мы делаем перенапралвение на страницу со списком
      # тестирований.
      #
      # Если save возвращает false, это значит, что объект в базу данных не 
      # сохранился. Отрисовывается страница для создания (view для метода new),
      # при этом будет выведено сообщение с описанием возникшей ошибки.
      #
      # Объект может быть не сохранен в базе по причине того, что поля не
      # проходят условия валидации. Например, для модели Testing у нас
      # определено условие, что timeout строго больше 0.
      #
      if @testing.save
        format.html { redirect_to master_testings_url, notice: 'Testing was successfully created.' }
        format.json { render :show, status: :created, location: @testing }
      else
        format.html { render :new }
        format.json { render json: @testing.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Обновление объекта. 
  #
  # PATCH/PUT /testings/1
  # PATCH/PUT /testings/1.json
  def update
    #
    # В зависимости от формата запроса - html или json - определяется отрисовка
    #
    respond_to do |format|
      #
      # Для объекта @testing проставляются поля, переданные из html формы.
      # Аналогично как при создании объекта, выполняется проверка условий 
      # валидации
      #
      if @testing.update(testing_params)
        format.html { redirect_to master_testings_url, notice: 'Testing was successfully updated.' }
        format.json { render :show, status: :ok, location: @testing }
      else
        format.html { render :edit }
        format.json { render json: @testing.errors, status: :unprocessable_entity }
      end
    end
  end

  # 
  # Удаление объекта
  #
  # DELETE /testings/1
  # DELETE /testings/1.json
  def destroy
    # 
    # Удаление объекта
    #
    @testing.destroy

    #
    # Отрисовка в зависимости от формата запроса
    #
    respond_to do |format|
      format.html { redirect_to master_testings_url, notice: 'Testing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #
  # Метод отвечате за отображение списка вопросов для теста. Метод пустой, так
  # как необходимый объект был выбран чере before_action, а основной код
  # отрисовки находится во views
  #
  def questions
  end

  private
    #
    # Устанавливаем объект @testing по параметру id в запросе
    #
    def set_testing
      @testing = Testing.find(params[:id])
    end

    #
    # Определяет 'белый список' параметров, которые приходят от html-формы и 
    # могут быть использованы в массовом назначении для моделей (как, например,
    # при создании или редактировании)
    #
    def testing_params
      params.require(:testing).permit(:title, :description, :timeout, :random_questions, :random_answers)
    end
end
