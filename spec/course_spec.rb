require 'rails_helper'

describe 'Course' do
  let(:course) { FactoryBot.create(:course) }
  let(:student1) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }
  let(:student2) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

  it 'contains valid attributes' do
    expect(course).to be_valid
  end

  it 'can have many students through enrollments' do
    Enrollment.create(course: course, student: student1)
    Enrollment.create(course: course, student: student2)
    expect(course.students).to include(student1, student2)
  end

  it 'can have many groups' do
    group1 = course.groups.create
    group2 = course.groups.create
    expect(course.groups).to include(group1, group2)
  end

  it 'allows creation of groups associated with it' do
    group1 = course.groups.create
    group2 = course.groups.create
    expect(course.groups).to include(group1, group2)
  end

  it 'deletes associated groups when the course is deleted' do
    course.groups.create
    expect { course.destroy }.to change(Group, :count).by(-1)
  end

  it 'links students to the course through groups' do
    group = course.groups.create

    enrollment = Enrollment.create(course: course, student: student1)
    expect(enrollment).to be_persisted
    expect(course.students).to include(student1)
  end
end
