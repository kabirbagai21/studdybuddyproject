require 'rails_helper'
require_relative '../app/models/group.rb'



describe 'Group' do
  it 'contains valid attributes' do
    course = Course.create(id: 1, name: 'History')
    group = Group.new(group_id: 1, course_id: 1, created_at: Time.now, updated_at: Time.now)
    expect(group).to be_valid
  end

  it 'is not valid without a course_id' do
    group = Group.new(group_id: 1)
    expect(group).to_not be_valid
  end

  it 'belongs to a course' do
    course = Course.create(name: 'History')
    group = course.groups.create(group_id: 1)
    expect(group.course).to eq(course)
  end

  it 'can have and belong to many students' do
    group = Group.create(group_id: 1, course_id: 1, created_at: Time.now, updated_at: Time.now)
    student1 = Student.create(name: 'Alice', email: 'alice@example.com')
    student2 = Student.create(name: 'Bob', email: 'bob@example.com')
    group.students << student1
    group.students << student2
    expect(group.students).to include(student1, student2)
  end

  # New tests
  describe 'associations' do
    it 'belongs to a course' do
      course = Course.create(name: 'Mathematics')
      group = Group.create(course: course)
      expect(group.course).to eq(course)
    end

    it 'can have and belong to many students' do
      course = Course.create(name: 'Mathematics') # Ensure a course exists
      group = Group.create(course_id: course.id, created_at: Time.now, updated_at: Time.now)
      student1 = Student.create(name: 'Alice')
      student2 = Student.create(name: 'Bob')
      group.students << [student1, student2]
      expect(group.students).to include(student1, student2)
    end
  end
end
