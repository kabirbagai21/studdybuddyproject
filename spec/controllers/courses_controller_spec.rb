require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:course) { FactoryBot.create(:course) }
  let(:student) { FactoryBot.create(:student) }
  let(:group) { FactoryBot.create(:group, course: course) }

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
      expect(assigns(:user_groups)).to eq(student.groups.find_by(course: course))
    end
  end
end
