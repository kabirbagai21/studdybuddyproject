require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:student) { FactoryBot.create(:student) }
  let(:group) { FactoryBot.create(:group, group_owner_id: student.id) }
  let(:course) { group.course }

  before do
    sign_in student
  end

  describe 'GET #show' do
    it 'assigns the requested group and its details' do
      get :show, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
      expect(assigns(:course)).to eq(group.course)
    end
  end

  describe 'POST #new' do
    context 'when the student can create a group' do
      it 'creates a new group and redirects' do
        post :new, params: { course_id: course.id }
        expect(response).to redirect_to(course_path(course))
      end
    end

  end

  describe 'PATCH #leave' do
        context 'when a student leaves a group' do
            it 'removes the student from the group and redirects' do
            patch :leave, params: { id: group.id }
            expect(response).to redirect_to(course_path(group.course))
            end
        end
    end

  describe 'DELETE #destroy' do
    it 'deletes the group and redirects' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(course_path(course))
    end
  end

end
