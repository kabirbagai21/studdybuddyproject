class GroupsController < ApplicationController
    def show
        @group = Group.find(params[:id])
        @members = @group.students
        @course = @group.course
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
