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

    context 'when the student is already in a group for the course' do
      it 'does not allow creating a new group and redirects' do
        FactoryBot.create(:group, course: course, students: [student])
        post :new, params: { course_id: course.id }
        expect(response).to redirect_to(course_path(course))
        expect(flash[:alert]).to eq("You cannot create more than one group in a course.")
      end
    end

    context 'when the student has requested to join another group in the course' do
      it 'does not allow creating a new group and redirects' do
        other_group = FactoryBot.create(:group, course: course)
        FactoryBot.create(:group_request, student: student, group: other_group)
        post :new, params: { course_id: course.id }
        expect(response).to redirect_to(course_path(course))
        expect(flash[:alert]).to eq("You cannot create more than one group in a course.")
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

    context 'when the group owner leaves' do
      it 'assigns a new group owner' do
        new_owner = FactoryBot.create(:student)
        group.students << new_owner
        patch :leave, params: { id: group.id }
        group.reload
        expect(group.group_owner_id).to eq(new_owner.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the group and redirects' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(course_path(course))
    end

    it 'removes students from the group and deletes it' do
      other_student = FactoryBot.create(:student)
      group.students << other_student
      delete :destroy, params: { id: group.id }
      expect(Group.exists?(group.id)).to be_falsey
      other_student.reload
      expect(other_student.groups).to_not include(group)
    end
  end

  describe 'POST #enroll_student' do
    let(:other_student) { FactoryBot.create(:student) }

  end
end
