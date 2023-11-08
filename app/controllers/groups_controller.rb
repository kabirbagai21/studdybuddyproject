class GroupsController < ApplicationController
    def show
        @group = Group.find(params[:id])
        @course = @group.course
        @owner_name = Student.find(@group.group_owner_id).name
    end 

    def new
      @course = Course.find(params[:course_id])

      if Group.where(group_owner_id: current_student.id).exists?
        flash[:alert] = "You cannot create more than one group."
        redirect_to course_path(@course)
        return
      end

      @group = @course.groups.new
      @group.group_owner_id = current_student.id
      @group.students << current_student
      @group.save
      redirect_to course_path(@course)
    end
    
    def enroll_student
        group = Group.find(params[:group_id])
        student = Student.find(params[:student_id])
      
        if group.students.count < group.max_students
          group.students << student
          redirect_to group, notice: 'Successfully enrolled in the group.'
        else
          redirect_to group, alert: 'Group is full. Cannot enroll.'
        end
    end

end
