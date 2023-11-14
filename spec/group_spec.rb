require 'rails_helper'
require_relative '../app/models/group.rb'

describe 'Group' do
  it 'contains valid attributes' do
    course = Course.create(name: 'History')
    group = Group.new(course: course)
    expect(group).to be_valid
  end

  it 'is not valid without a course_id' do
    group = Group.new
    expect(group).to_not be_valid
  end

  it 'belongs to a course' do
    course = Course.create(name: 'History')
    group = course.groups.create
    expect(group.course).to eq(course)
  end

  it 'can have and belong to many students' do
    course = Course.create(name: 'Mathematics')
    group = Group.create(course: course)
    student1 = Student.create(name: 'Alice', email: 'alice@example.com', password: 'password1')
    student2 = Student.create(name: 'Bob', email: 'bob@example.com', password: 'password2')
    group.students << student1
    group.students << student2
    expect(group.students).to include(student1, student2)
  end

  describe 'Group creation' do
    let(:course) { Course.create(name: 'Mathematics') }
    let(:student) { Student.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

    it 'allows a user to create a group' do
      group = Group.create(course_id: course.id, group_owner_id: student.id)
      expect(group).to be_valid
    end

    it 'does not allow a user to create more than one group' do
      Group.create(course_id: course.id, group_owner_id: student.id)
      second_group = Group.new(course_id: course.id, group_owner_id: student.id)
      expect(second_group.valid?).to be_falsey
    end

    it 'sets the group owner correctly' do
      group = Group.create(course_id: course.id, group_owner_id: student.id)
      expect(group.group_owner_id).to eq(student.id)
    end
  end
end
