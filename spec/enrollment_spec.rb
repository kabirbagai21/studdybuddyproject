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

  # New tests

  it 'does not allow duplicate enrollment for the same course and student' do
    student = Student.create(name: 'Bob', email: 'bob@example.com')
    course = Course.create(name: 'Mathematics')
    Enrollment.create(student: student, course: course)
    duplicate_enrollment = Enrollment.new(student: student, course: course)
    expect(duplicate_enrollment).to_not be_valid
  end

  it 'increases enrollment count when a new enrollment is created' do
    student = Student.create(name: 'Charlie', email: 'charlie@example.com')
    course = Course.create(name: 'Physics')
    expect { Enrollment.create(student: student, course: course) }.to change(Enrollment, :count).by(1)
  end

  it 'can be deleted' do
    student = Student.create(name: 'Dave', email: 'dave@example.com')
    course = Course.create(name: 'Art')
    enrollment = Enrollment.create(student: student, course: course)
    expect { enrollment.destroy }.to change(Enrollment, :count).by(-1)
  end

end
