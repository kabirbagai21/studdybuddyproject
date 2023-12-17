class MergeGroupRequestsController < ApplicationController
    def new
        @requesting_group = Group.find(params[:group_requesting_id])
        @group_to_merge = Group.find(params[:group_to_merge_id]) 
        @course = Course.find(params[:course_id])
        if @requesting_group.students.count + @group_to_merge.students.count > @course.max_group_size
            redirect_to group_path(@group_to_merge), alert: 'Merging with this group would exceed the maximum allowed group size for this course'
            return
        elsif @group_to_merge.requesting_groups.include?(@requesting_group)
            redirect_to group_path(@group_to_merge), alert: 'You have already requested to join. Please wait for someone in the group to approve your request'
            return
        elsif @requesting_group.requested_groups.where(course: @course).count >= 1
            flash[:notice] = "You are requesting to merge with multiple groups. Once you are accepted into a group, all other requests will be canceled."
        end 
        
        @merge_group_request = MergeGroupRequest.new(group_requesting: @requesting_group, group_to_merge: @group_to_merge, course: @course)
        @merge_group_request.save
        redirect_to group_path(@group_to_merge), notice: "Requested to Join"
    end

    def approve
        @requesting_group = Group.find(params[:group_requesting_id])
        @group_to_merge = Group.find(params[:group_to_merge_id]) 
        @course = Course.find(params[:course_id])

        if @requesting_group.students.count + @group_to_merge.students.count > @course.max_group_size
            redirect_to group_path(@group_to_merge), alert: 'Merging with this group would exceed the maximum allowed group size for this course'
            return
        end
        @group_to_merge.students << @requesting_group.students
        MergeGroupRequest.find_by(group_requesting: @requesting_group, group_to_merge: @group_to_merge, course: @course).destroy
        @requesting_group.students.each do |student|
            student.groups.delete(@requesting_group)
        end

        @requesting_group.destroy
        @num_students = @group_to_merge.students.count
        if(@num_students >= @course.max_group_size)
            GroupRequest.where(group: @group_to_merge, course: @course).destroy_all
            MergeGroupRequest.where(group_to_merge: @group_to_merge, course: @course).destroy_all
            redirect_to group_path(@group_to_merge), notice: "Group is now full"
            return
        end
        redirect_to group_path(@group_to_merge)
    end

    def destroy
        @requesting_group = Group.find(params[:group_requesting_id])
        @group_to_merge = Group.find(params[:group_to_merge_id])
        @request = MergeGroupRequest.find_by(group_requesting_id: @requesting_group.id, group_to_merge_id: @group_to_merge.id, course: params[:course_id])
        if @request
          @request.destroy
          flash[:notice] = 'Request Canceled.'
          redirect_to group_path(@group_to_merge)
        else
          # Redirect to the root path if the merge request does not exist
          redirect_to root_path, alert: 'Merge request not found.'
        end
      end

    
end
