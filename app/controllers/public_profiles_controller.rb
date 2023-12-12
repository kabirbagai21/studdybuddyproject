class PublicProfilesController < ApplicationController
  def show
    begin
      @student = Student.find(params[:id])
      @group = Group.find(params[:group_id]) if params[:group_id].present?
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Student not found"
    end
  end
end
