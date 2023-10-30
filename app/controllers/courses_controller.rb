class CoursesController < ApplicationController
    def show
        @course = Course.find(params[:id])
        @enrolled_students = @course.students
        @groups = @course.groups
    end
end
