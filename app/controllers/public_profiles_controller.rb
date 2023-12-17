class PublicProfilesController < ApplicationController
  def show
    @student = Student.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id].present?
    @courses = @student.courses
  end
end
