class StudentsController < ApplicationController

  before_action :authenticate_student!, only: [:show]

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(current_student.id)
    @enrolled_courses = @student.courses

    if @student.instructor?
      @courses_taught = Course.where(instructor_id: @student.id).all
    end

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
      if student.courses.include?(course)
        redirect_to student_path(student), notice: 'You are already enrolled in this course.'
      else
        student.courses << course
        redirect_to student_path(student), notice: 'Successfully enrolled in the course.'
      end
    else
      redirect_to student_path(student)
      flash[:alert]= "Invalid Course ID. Please try again."
    end
    
  end

  def student_params
    params.require(:student).permit(:name, :email, :bio, :linked_in_profile, :facebook_profile, :personal_website, :github_profile, :skills )
  end



end
