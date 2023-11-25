class GroupRequestsController < ApplicationController
    def new
        @group = Group.find(params[:group_id]) 
        @student = Student.find(params[:student_id])
        @course = Course.find(params[:course_id])
        if @student.requested_groups.include?(@group)
            redirect_to group_path(@group), alert: 'You have already requested to join. Please wait for someone in the group to approve your request'
            return
        elsif @student.groups.where(course_id: @course.id).exists?
            redirect_to group_path(@group), alert: "You are already in a group for this course. Please leave the group you are in to request to join another."
            return
        elsif @student.requested_groups.where(course: @course).count >= 1
            flash[:notice] = "You are requesting to join multiple groups. Once you are accepted into a group, all other requests will be canceled."
        end 
        
        @group_request = GroupRequest.new(group: @group, student: @student, course: @course)
        @group_request.save
        redirect_to group_path(@group), notice: "Requested to Join"
    end

    def approve
        @group = Group.find(params[:id]) 
        @course = Course.find(@group.course_id)
        @student = Student.find(params[:student_id])
        @group.students << @student
        GroupRequest.where(student: @student, course: @course).destroy_all
        @num_students = @group.students.count
        if(@num_students >= @course.max_group_size)
            GroupRequest.where(group: @group, course: @course).destroy_all
            redirect_to group_path(@group), notice: "Group is now full"
        end
        redirect_to group_path(@group)
    end

    def destroy
        @group = Group.find(params[:group_id])
        @request = GroupRequest.find_by(group_id: @group.id, student_id: params[:student_id])
        @request.destroy
        flash[:notice] = 'Request Canceled.'
        redirect_to group_path(@group)
    end
end
