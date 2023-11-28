require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'sequential_id functionality' do
    it 'assigns a sequential_id to a new group' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = Course.create(
        name: 'Intro to Ruby',
        course_code: 'RUBY101',
        max_group_size: 5,
        instructor_id: instructor.id,
        year: 2023,
        section: 'A',
        semester: 'Fall'
      )
      group = Group.create(course: course)
      expect(group.sequential_id).to eq(1)
    end

    it 'recalculates sequential_id after a group is destroyed' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = Course.create(
        name: 'Intro to Ruby',
        course_code: 'RUBY101',
        max_group_size: 5,
        instructor_id: instructor.id,
        year: 2023,
        section: 'A',
        semester: 'Fall'
      )

      student1 = Student.create(email: 'student1@example.com', password: 'password', password_confirmation: 'password')
      student2 = Student.create(email: 'student2@example.com', password: 'password', password_confirmation: 'password')

      group1 = Group.create(course: course, group_owner_id: student1.id)
      group2 = Group.create(course: course, group_owner_id: student2.id)

      expect(group1.persisted?).to be true
      expect(group2.persisted?).to be true

      group1_id = group1.id
      group2_id = group2.id
      group1.destroy

      expect { Group.find(group1_id) }.to raise_error(ActiveRecord::RecordNotFound)

      recalculated_group2 = Group.find(group2_id)
      expect(recalculated_group2.sequential_id).to eq(1)
    end
  end

  describe 'group_id functionality' do
    it 'assigns a unique group_id to a new group' do
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = Course.create(
        name: 'Intro to Ruby',
        course_code: 'RUBY101',
        max_group_size: 5,
        instructor_id: instructor.id,
        year: 2023,
        section: 'A',
        semester: 'Fall'
      )
      group = Group.create(course: course)
      expect(group.group_id).not_to be_nil
    end
  end

  describe 'one_group_per_student validation' do
    it 'prevents creating more than one group per student in a course' do
      student = Student.create(email: 'student@example.com', password: 'password', password_confirmation: 'password')
      instructor = Student.create(email: 'instructor@example.com', password: 'password', password_confirmation: 'password')
      course = Course.create(
        name: 'Intro to Ruby',
        course_code: 'RUBY101',
        max_group_size: 5,
        instructor_id: instructor.id,
        year: 2023,
        section: 'A',
        semester: 'Fall'
      )
      group_owner_id = student.id
      Group.create(course: course, group_owner_id: group_owner_id)
      new_group = Group.new(course: course, group_owner_id: group_owner_id)
      expect(new_group.valid?).to be_falsey
      expect(new_group.errors[:group_owner_id]).to include("can't create more than one group")
    end
  end
end
