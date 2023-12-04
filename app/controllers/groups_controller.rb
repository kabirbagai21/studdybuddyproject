class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
    @course = @group.course
    @owner_name = Student.find(@group.group_owner_id).name
    @current_student_group = current_student.groups.find_by(course_id: @course.id)
    @enrollment = @group.students.count
    @is_full = (@group.students.count == @course.max_group_size)
    @requests = @group.requesting_students
    @merge_requests = @group.requesting_groups
  end

  def new
    @course = Course.find(params[:course_id])

    if Group.where(group_owner_id: current_student.id, course_id: @course.id).exists?
      flash[:alert] = "You cannot create more than one group in a course."
      redirect_to course_path(@course)
      return
    elsif Group.where(course_id: @course.id).joins(:students).where(students: { id: current_student.id }).exists?
      flash[:alert] = "You are already in a group. Please leave the group you are in to create a new one."
      redirect_to course_path(@course)
      return
    elsif current_student.requested_groups.where(course: @course).exists?
      flash[:alert] = "You cannot create a group if you have requested to join another group in this course"
      redirect_to course_path(@course)
      return
    end

    @group = @course.groups.new
    @group.group_owner_id = current_student.id
    @group.students << current_student
    @group.save
    redirect_to course_path(@course)
  end

  def leave
    group = Group.find(params[:id])
    course = Course.find(group.course_id)
    if current_student.id == group.group_owner_id
      new_owner = group.students.where.not(id: current_student.id).sample
      if new_owner
        group.update(group_owner_id: new_owner.id)
      else
        current_student.groups.delete(group)
        group.destroy
        redirect_to course_path(course)
        return 
      end
    end
    current_student.groups.delete(group)
    redirect_to group_path(group), notice: 'You have left the group.'
  end 

  def destroy
    @group = Group.find(params[:id])
    @course = Course.find(@group.course_id)
    @group.group_requests.destroy_all
    @group.students.each do |student|
      student.groups.delete(@group)
    end
    sequential_id_to_recalibrate = @group.sequential_id
    @group.destroy

    # Recalibrate sequential_id after group destruction
    recalibrate_sequential_ids(sequential_id_to_recalibrate)

    flash[:notice] = 'Group deleted successfully.'
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

  private

  def recalibrate_sequential_ids(deleted_sequential_id)
    Group.where('sequential_id > ?', deleted_sequential_id).order(:sequential_id).each do |group|
      group.update_column(:sequential_id, group.sequential_id - 1)
    end
  end
end
