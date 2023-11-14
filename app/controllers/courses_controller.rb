class CoursesController < ApplicationController
    def show
        @course = Course.find(params[:id])
        @enrolled_students = @course.students
        @groups = @course.groups
        @user_groups = current_student.groups.where(course: @course)
    end
end
