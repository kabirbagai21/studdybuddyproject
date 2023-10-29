class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find params[:id]
  end

  def update
    @student = Student.find params[:id]
    @student.update(student_params)
    redirect_to student_path(@student)
  end


  def student_params
    params.require(:student).permit(:name, :email, :bio)
  end

end
