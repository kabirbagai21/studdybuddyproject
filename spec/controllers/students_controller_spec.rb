require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:student) { FactoryBot.create(:student) }
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
    it 'assigns the requested student to @student' do
      get :show
      expect(assigns(:student)).to eq(student)
      expect(assigns(:enrolled_courses)).to match_array(student.courses)
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
  end
end
