require 'rails_helper'
require_relative '../app/models/enrollment.rb'



describe 'Enrollment' do
  it 'contains valid attributes' do
    student = Student.create(name: 'Alice', email: 'alice@example.com', email_old: 'alice@example.com', password: '123456')
    course = Course.create(name: 'History')
    enrollment = Enrollment.new(student_id: 1, course_id: 1, created_at: Time.now, updated_at: Time.now)
    expect(enrollment).to be_valid
  end

  it 'is not valid without a student_id' do
    enrollment = Enrollment.new(course_id: 1)
    expect(enrollment).to_not be_valid
  end

  it 'is not valid without a course_id' do
    enrollment = Enrollment.new(student_id: 1)
    expect(enrollment).to_not be_valid
  end

  it 'belongs to a student' do
    student = Student.create(name: 'Alice', email: 'alice@example.com', email_old: 'alice@example.com', password: '123456')
    enrollment = Enrollment.create(student_id: student.id, course_id: 1)
    expect(enrollment.student).to eq(student)
  end

  it 'belongs to a course' do
    course = Course.create(name: 'History')
    enrollment = Enrollment.create(student_id: 1, course_id: course.id)
    expect(enrollment.course).to eq(course)
  end

end
