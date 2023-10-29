class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @enrolled_courses = @student.courses
    
  end

  def edit
    @student = Student.find params[:id]
  end

  def update
    @student = Student.find params[:id]
    @student.update(student_params)
    redirect_to student_path(@student)
  end


  def enroll
    course_id = params[:course_id]
    course = Course.find_by(course_id: course_id)
    student = Student.find(params[:id])
    if course
      unless student.courses.include?(course)
        student.courses << course
        course.students << student
        redirect_to student_path(student), notice: 'Successfully enrolled in the course.'
      end 
    else
      redirect_to student_path(student), alert: 'Invalid Course ID. Please try again.'
    end
    
  end

  def student_params
    params.require(:student).permit(:name, :email, :bio)
  end



end
