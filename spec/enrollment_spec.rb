require 'rails_helper'
require_relative '../app/models/enrollment.rb'

describe 'Enrollment' do
  before do
    @student = Student.create(name: 'Alice', email: 'alice@example.com', password: '123456')
    @course = Course.create(name: 'History')
  end

  it 'contains valid attributes' do
    enrollment = Enrollment.new(student: @student, course: @course)
    expect(enrollment).to be_valid
  end

  it 'is not valid without a student_id' do
    enrollment = Enrollment.new(course: @course)
    expect(enrollment).to_not be_valid
  end

  it 'is not valid without a course_id' do
    enrollment = Enrollment.new(student: @student)
    expect(enrollment).to_not be_valid
  end

  it 'belongs to a student' do
    enrollment = Enrollment.create(student: @student, course: @course)
    expect(enrollment.student).to eq(@student)
  end

  it 'belongs to a course' do
    enrollment = Enrollment.create(student: @student, course: @course)
    expect(enrollment.course).to eq(@course)
  end

  it 'does not allow duplicate enrollment for the same course and student' do
    Enrollment.create(student: @student, course: @course)
    duplicate_enrollment = Enrollment.new(student: @student, course: @course)
    expect(duplicate_enrollment).to_not be_valid, "Duplicate enrollment was unexpectedly valid"
  end

  it 'increases enrollment count when a new enrollment is created' do
    expect { Enrollment.create(student: @student, course: @course) }.to change(Enrollment, :count).by(1)
  end

  it 'can be deleted' do
    enrollment = Enrollment.create(student: @student, course: @course)
    expect { enrollment.destroy }.to change(Enrollment, :count).by(-1)
  end
end
