class Master::StudentsController < MasterController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    sp = student_params rescue {}
    
    @students = Student.all.order(:surname, :name)
    
    if sp['group_id'].to_i > 0
      @students = @students.where(group_id: sp['group_id'].to_i)
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to master_students_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to master_students_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to master_students_path, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_passwords
    ids = params['ids'].split(",").map(&:to_i)
    
    result = [] 
    
    Student.where(id: ids).each do |student|
      password = SecureRandom.hex(4)
      student.password = password
      student.save!
      
      result << "#{student.fio}\t#{student.email}\t#{password}"
    end
    
    render plain: result.join("\n")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:surname, :name, :patronymic, :group_id)
    end
end
