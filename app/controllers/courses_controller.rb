class CoursesController < ApplicationController
    before_action :set_instructor, only: [:new, :create]

    def show
        @course = Course.find(params[:id])
        @enrolled_students = @course.students
        @groups = @course.groups
        @user_group = current_student.groups.find_by(course: @course)
        @instructor = Student.find_by(id: @course.instructor_id)
        @student = current_student
    end

    def edit
        @course = Course.find params[:id]
    end
    
    def update
        @course = Course.find params[:id]
        @course.update(course_params)
        redirect_to course_path(@course)
    end

    def new
        @course = Course.new
    end

    def create
        @course = Course.new(course_params)
        @course.instructor_id = @instructor.id
        if @course.save
          redirect_to @course, notice: 'Course was successfully created.'
        else
          render :new
        end
    end

    def destroy
        @course = Course.find(params[:id])
        @course.group_requests.destroy_all
        @course.groups.each do |group|
            group.students.clear
        end
        @course.groups.destroy_all
        @course.students.each do |student|
          student.courses.delete(@course)
        end
        @instructor = Student.find_by(id: @course.instructor_id)
        @instructor.courses.delete(@course)
        @course.destroy
        flash[:notice] = 'Course deleted successfully.'
        redirect_to root_path
    end

  private 

  def set_instructor
    @instructor = Student.find(params[:instructor_id])
  end

  def course_params
    params.require(:course).permit(:name, :course_code, :max_group_size, :section, :year, :semester)
  end

end
