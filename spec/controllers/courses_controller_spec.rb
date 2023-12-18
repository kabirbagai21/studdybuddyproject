require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:course) { FactoryBot.create(:course) }
  let(:student) { FactoryBot.create(:student) }
  let(:group) { FactoryBot.create(:group, course: course) }
  let(:instructor) { FactoryBot.create(:student) } # Assuming instructor is a student

  before do
    sign_in student
    student.groups << group
  end

  describe 'GET #show' do
    it 'assigns the requested course and its details' do
      get :show, params: { id: course.id }

      expect(assigns(:course)).to eq(course)
      expect(assigns(:enrolled_students)).to match_array(course.students)
      expect(assigns(:groups)).to match_array(course.groups)
      expect(assigns(:user_group)).to eq(student.groups.find_by(course: course))
      expect(assigns(:instructor)).to eq(Student.find_by(id: course.instructor_id))
      expect(assigns(:student)).to eq(student)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested course for editing' do
      get :edit, params: { id: course.id }

      expect(assigns(:course)).to eq(course)
    end
  end

  describe 'PUT #update' do
    let(:updated_attributes) { { name: 'Updated Course Name' } }

    it 'updates the course and redirects' do
      put :update, params: { id: course.id, course: updated_attributes }

      expect(course.reload.name).to eq('Updated Course Name')
      expect(response).to redirect_to(course_path(course))
    end
  end

  describe 'GET #new' do
    it 'assigns a new course' do
      get :new, params: { instructor_id: instructor.id }

      expect(assigns(:course)).to be_a_new(Course)
    end
  end

  describe 'POST #create' do
    let(:course_params) { FactoryBot.attributes_for(:course) }

    it 'creates a new course and redirects' do
      expect {
        post :create, params: { course: course_params, instructor_id: instructor.id }
      }.to change(Course, :count).by(1)

      expect(response).to redirect_to(Course.last)
      expect(flash[:notice]).to eq('Course was successfully created.')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the course and redirects to root path' do
      course.update(instructor_id: instructor.id)

      delete :destroy, params: { id: course.id }

      expect(Course.exists?(course.id)).to be_falsey
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Course deleted successfully.')
    end
  end

  private

  def set_instructor
    @instructor = Student.find(params[:instructor_id])
  end

  def course_params
    params.require(:course).permit(:name, :course_code, :max_group_size, :section, :year, :semester)
  end
end
