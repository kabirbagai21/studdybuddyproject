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
    student1 = Student.create(name: 'Alice', email: 'alice@example.com')
    student2 = Student.create(name: 'Bob', email: 'bob@example.com')
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

end



