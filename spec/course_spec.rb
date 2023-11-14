require 'rails_helper'
require_relative '../app/models/course.rb'



describe 'Course' do
  # Check the proper attributes provided
  it "contains valid attributes" do
    course = Course.new(name: "COMS1234", course_id: "1234")
    expect(course.name).to be_present
    expect(course.course_id).to be_present
    expect(course).to be_valid
  end


  it 'can have many students through enrollments' do
    course = Course.create(name: 'Science')
    student1 = Student.create(name: 'Alice', email_old: 'alice@example.com', email: 'alice@example.com', password: '123456')
    student2 = Student.create(name: 'Bob', email_old: 'bob@example.com', email: 'bob@example.com', password: '123456')
    Enrollment.create(course: course, student: student1)
    Enrollment.create(course: course, student: student2)
    expect(course.students).to include(student1, student2)
  end

  it 'can have many groups' do
    course = Course.create(name: 'History')
    group1 = course.groups.create(group_id: 1)
    group2 = course.groups.create(group_id: 2)
    expect(course.groups).to include(group1, group2)
  end


  it 'allows creation of groups associated with it' do
    course = Course.create(name: 'Mathematics')
    group1 = course.groups.create
    group2 = course.groups.create
    expect(course.groups).to include(group1, group2)
  end

  it 'deletes associated groups when the course is deleted' do
    course = Course.create(name: 'Philosophy')
    course.groups.create
    expect { course.destroy }.to change(Group, :count).by(-1)
  end

  it 'links students to the course through groups' do
    course = Course.create(name: 'Computer Science')
    group = course.groups.create

    student = Student.new(name: 'Charlie', email: 'charlie@example.com', password: 'password123')
    if student.save
      expect(student).to be_persisted
    else
      raise "Student creation failed: #{student.errors.full_messages.join(", ")}"
    end

    enrollment = Enrollment.create(course: course, student: student)
    expect(enrollment).to be_persisted, "Enrollment was not successfully created"
    expect(course.students).to include(student)
  end
end


