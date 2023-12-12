require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:student) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }
  let(:course) { FactoryBot.create(:course) }
  let(:enrolled_course) { FactoryBot.create(:course) }

  before do
    sign_in student
  end

  describe 'GET #index' do
    it 'assigns all students to @students' do
      get :index
      expect(assigns(:students)).to eq([student])
    end
  end

  describe 'GET #show' do
    context 'when the student is not an instructor' do
      it 'assigns the requested student to @student and enrolled courses' do
        get :show, params: { id: student.id }
        expect(assigns(:student)).to eq(student)
        expect(assigns(:enrolled_courses)).to match_array(student.courses)
      end
    end

    context 'when the student is an instructor' do
      let(:instructor) { FactoryBot.create(:student, instructor: true, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

      it 'assigns courses taught by the instructor' do
        sign_in instructor
        course.update(instructor_id: instructor.id)
        get :show, params: { id: instructor.id }
        expect(assigns(:courses_taught)).to include(course)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested student to @student for editing' do
      get :edit, params: { id: student.id }
      expect(assigns(:student)).to eq(student)
    end
  end

  describe 'PATCH #update' do
    it 'updates the student and redirects to the student show page' do
      patch :update, params: { id: student.id, student: { name: 'Updated Name' } }
      expect(response).to redirect_to(student_path(student))
      expect(student.reload.name).to eq('Updated Name')
    end
  end

  describe 'POST #enroll' do
    context 'when the course does not exist' do
      it 'redirects to the student show page with an alert' do
        post :enroll, params: { id: student.id, course_id: 0 }
        expect(response).to redirect_to(student_path(student))
        expect(flash[:alert]).to eq('Invalid Course ID. Please try again.')
      end
    end

    context 'when the student is already enrolled in the course' do
      before do
        student.courses << enrolled_course
        student.save
      end
  
      it 'redirects with a notice indicating already enrolled' do
        post :enroll, params: { id: student.id, course_id: enrolled_course.course_id }
        expect(response).to redirect_to(student_path(student))
        expect(flash.to_hash).to include('notice' => 'You are already enrolled in this course.')
      end
    end
  
    context 'when the student is not already enrolled in the course' do
      it 'enrolls the student and redirects with a success notice' do
        post :enroll, params: { id: student.id, course_id: course.course_id }
        expect(response).to redirect_to(student_path(student))
        expect(student.reload.courses).to include(course)
        expect(flash.to_hash).to include('notice' => 'Successfully enrolled in the course.')
      end
    end
  end
end
