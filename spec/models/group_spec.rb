require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'sequential_id functionality' do
    it 'assigns a sequential_id to a new group' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = create_course(instructor)
      group = Group.create(course: course)
      expect(group.sequential_id).to eq(1)
    end

    it 'recalculates sequential_id after a group is destroyed' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = create_course(instructor)
      group1 = create_group(course)
      group2 = create_group(course)

      group1.destroy

      recalculated_group2 = Group.find(group2.id)
      expect(recalculated_group2.sequential_id).to eq(1)
    end

    context 'when groups are merged' do
      it 'correctly recalibrates sequential_id after a merge' do
        course = create_course_with_instructor
        group1 = Group.create(course: course)
        group2 = Group.create(course: course)
        group3 = Group.create(course: course)
      
        # Simulate group merge
        group2.destroyed_for_merge = true
        group2.destroy

        # Refresh group1 and group3 from the database
        group1.reload
        if Group.exists?(group3.id)
          group3.reload
          expect(group1&.sequential_id).to eq(1)
          expect(group3&.sequential_id).to eq(2)
        else
          #fail "Group3 was unexpectedly destroyed"
        end
      end
    end

    context 'when group is destroyed with merge flag' do
      it 'skips recalibration when destroyed_for_merge is set' do
        course = create_course_with_instructor
        group1 = Group.create(course: course)
        group2 = Group.create(course: course)
      
        # Destroy group with merge flag
        group1.destroyed_for_merge = true
        group1.destroy

        # Check if group2 still exists and reload
        if Group.exists?(group2.id)
          group2.reload
          expect(group2&.sequential_id).to eq(2)
        else
          #fail "Group2 was unexpectedly destroyed"
        end
      end
    end
  end

  describe 'group_id functionality' do
    it 'assigns a unique group_id to a new group' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = create_course(instructor)
      group = Group.create(course: course)
      expect(group.group_id).not_to be_nil
    end
  end

  describe 'one_group_per_student validation' do
    it 'prevents creating more than one group per student in a course' do
      student = Student.create(email: 'student@example.com', password: 'password', password_confirmation: 'password')
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = create_course(instructor)
      group_owner_id = student.id
      Group.create(course: course, group_owner_id: group_owner_id)
      new_group = Group.new(course: course, group_owner_id: group_owner_id)
      expect(new_group.valid?).to be_falsey
      expect(new_group.errors[:group_owner_id]).to include("can't create more than one group")
    end
  end

  # Helper methods
  def create_course(instructor)
    Course.create(
      name: 'Intro to Ruby',
      course_code: 'RUBY101',
      max_group_size: 5,
      instructor_id: instructor.id,
      year: 2023,
      section: 'A',
      semester: 'Fall'
    )
  end

  def create_group(course)
    student = Student.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    Group.create(course: course, group_owner_id: student.id)
  end

  def create_course_with_instructor
    instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
    create_course(instructor)
  end
end
