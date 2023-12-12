require 'rails_helper'

RSpec.describe Student, type: :model do
  it "contains valid attributes" do
    student = Student.new(name: "John Doe", email: "john@columbia.edu", password: '123456', bio: "A bio.")
    expect(student).to be_valid
  end

  it "can allow to update profile" do
    student = FactoryBot.create(:student)
    student.update(bio: "Another bio.")
    expect(student.bio).to eq("Another bio.")
  end

  it 'can have many enrollments' do
    student = FactoryBot.create(:student)
    course1 = FactoryBot.create(:course)
    course2 = FactoryBot.create(:course)
    Enrollment.create(course: course1, student: student)
    Enrollment.create(course: course2, student: student)
    expect(student.enrollments.count).to eq(2)
  end

  it 'can have many courses through enrollments' do
    student = FactoryBot.create(:student)
    course1 = FactoryBot.create(:course)
    course2 = FactoryBot.create(:course)
    student.courses << course1
    student.courses << course2
    expect(student.courses).to include(course1, course2)
  end
end
