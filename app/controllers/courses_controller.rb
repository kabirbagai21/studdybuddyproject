class CoursesController < ApplicationController
    def show
        @course = Course.find(params[:id])
        @enrolled_students = @course.students
    end
end
