require 'rails_helper'
require_relative '../app/models/student.rb'
require 'rails_helper'

RSpec.describe Student, type: :model do
  # Check the proper attributes provided
  it "contains valid attributes" do
    student = Student.new(name: "John Doe", email: "john@example.com", bio: "A bio.", created_at: Time.now, updated_at: Time.now)
    expect(student).to be_valid
  end

  # Check if student profile can be updated
  it "can allow to update profile" do
    student = Student.new(name: "John Doe", email: "john@example.com", bio: "A bio.", created_at: Time.now, updated_at: Time.now)
    student.update(bio: "Another bio.")
    expect(student.bio).to eq("Another bio.")
  end 

  it 'can have many enrollments' do
    student = Student.new(name: 'Jane Smith', email: 'jane.smith@example.com', created_at: Time.now, updated_at: Time.now)
    enrollment1 = student.enrollments.build(course_id: 1)
    enrollment2 = student.enrollments.build(course_id: 2)
    expect(student.enrollments).to include(enrollment1, enrollment2)
  end

  it 'can have many courses through enrollments' do
    student = Student.new(name: 'Bob Johnson', email: 'bob.johnson@example.com', created_at: Time.now, updated_at: Time.now)
    course1 = Course.create(name: 'Math')
    course2 = Course.create(name: 'Science')
    student.courses << course1
    student.courses << course2
    expect(student.courses).to include(course1, course2)
  end

end