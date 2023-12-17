require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:student) { FactoryBot.create(:student) }
  let(:other_student) { FactoryBot.create(:student) }
  let(:group) { FactoryBot.create(:group, group_owner_id: student.id, students: [student]) }
  let(:course) { group.course }

  before do
    sign_in student
  end

  describe 'GET #show' do
    it 'assigns the requested group and its details' do
      get :show, params: { id: group.id }
      expect(assigns(:group)).to eq(group)
      expect(assigns(:course)).to eq(group.course)
      expect(assigns(:owner_name)).to eq(student.name)
      expect(assigns(:enrollment)).to eq(1)
      expect(assigns(:is_full)).to eq(false)
      expect(assigns(:requests)).to match_array(group.requesting_students)
      expect(assigns(:merge_requests)).to match_array(group.requesting_groups)
    end
  end

  describe 'POST #new' do
    context 'when the student can create a group' do
      it 'creates a new group and redirects' do
        post :new, params: { course_id: course.id }
        expect(response).to redirect_to(course_path(course))
        expect(Group.last.group_owner_id).to eq(student.id)
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
        group.students << student
        patch :leave, params: { id: group.id }
        expect(response).to redirect_to(course_path(group.course))

        if Group.exists?(group.id)
          expect(group.reload.students).not_to include(student)
        else
          expect(Group.exists?(group.id)).to be_falsey
        end
      end
    end

    context 'when the group owner leaves' do
      it 'assigns a new group owner or deletes the group' do
        group.students << other_student
        patch :leave, params: { id: group.id }
        group.reload
        if group.students.empty?
          expect(Group.exists?(group.id)).to be_falsey
          expect(response).to redirect_to(course_path(course))
        else
          expect(group.group_owner_id).to eq(other_student.id)
          expect(response).to redirect_to(group_path(group))
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the group and redirects' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(course_path(course))
      expect(Group.exists?(group.id)).to be_falsey
    end
  end

end
