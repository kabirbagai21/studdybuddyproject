require 'rails_helper'

describe 'Enrollment' do
  let(:student) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }
  let(:course) { FactoryBot.create(:course) }

  context 'validations and associations' do
    it 'contains valid attributes' do
      enrollment = Enrollment.new(student: student, course: course)
      expect(enrollment).to be_valid
    end

    it 'is not valid without a student_id' do
      enrollment = Enrollment.new(course: course)
      expect(enrollment).to_not be_valid
    end

    it 'is not valid without a course_id' do
      enrollment = Enrollment.new(student: student)
      expect(enrollment).to_not be_valid
    end

    it 'belongs to a student' do
      enrollment = Enrollment.create(student: student, course: course)
      expect(enrollment.student).to eq(student)
    end

    it 'belongs to a course' do
      enrollment = Enrollment.create(student: student, course: course)
      expect(enrollment.course).to eq(course)
    end

    it 'does not allow duplicate enrollment for the same course and student' do
      Enrollment.create(student: student, course: course)
      duplicate_enrollment = Enrollment.new(student: student, course: course)
      expect(duplicate_enrollment).to_not be_valid
    end

    it 'increases enrollment count when a new enrollment is created' do
      expect { Enrollment.create(student: student, course: course) }.to change(Enrollment, :count).by(1)
    end

    it 'can be deleted' do
      enrollment = Enrollment.create(student: student, course: course)
      expect { enrollment.destroy }.to change(Enrollment, :count).by(-1)
    end
  end
end
