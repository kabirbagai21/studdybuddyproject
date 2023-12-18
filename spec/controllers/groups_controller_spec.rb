require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:student) { FactoryBot.create(:student) }
  let(:other_student) { FactoryBot.create(:student) }
  let(:course) { FactoryBot.create(:course) } 

  before do
    sign_in student
  end

  describe 'GET #show' do
    it 'assigns the requested group and its details' do
      group = FactoryBot.create(:group, group_owner_id: student.id, students: [student], course: course)
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
        expect(flash[:alert]).to eq("You are already in a group. Please leave the group you are in to create a new one.")
      end
    end

    context 'when the student has requested to join another group in the course' do
      before do
        other_group = FactoryBot.create(:group, course: course)
        FactoryBot.create(:group_request, student: student, group: other_group)
        post :new, params: { course_id: course.id }
      end

      it 'does not allow creating a new group and redirects' do
        expect(response).to redirect_to(course_path(course))
        expect(flash[:alert]).to eq("You cannot create a group if you have requested to join another group in this course")
      end
    end
  end

  describe 'PATCH #leave' do
    context 'when the group owner leaves and is the sole member' do
      it 'deletes the group' do
        group = FactoryBot.create(:group, group_owner_id: student.id, students: [student], course: course)
        patch :leave, params: { id: group.id }
        expect(Group.exists?(group.id)).to be_falsey
        expect(response).to redirect_to(course_path(course))
      end
    end

    context 'when the group owner leaves but other students are present' do
      it 'does not delete the group' do
        group = FactoryBot.create(:group, group_owner_id: student.id, students: [student, other_student], course: course)
        patch :leave, params: { id: group.id }
        expect(Group.exists?(group.id)).to be_truthy
        expect(response).to redirect_to(group_path(group))
      end
    end

    context 'when a non-owner student leaves the group' do
      it 'does not delete the group' do
        group = FactoryBot.create(:group, group_owner_id: other_student.id, students: [student, other_student], course: course)
        patch :leave, params: { id: group.id }
        expect(Group.exists?(group.id)).to be_truthy
        expect(response).to redirect_to(group_path(group))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the group, recalibrates sequential IDs, and redirects' do
      group = FactoryBot.create(:group, course: course, sequential_id: 1)
      additional_group_1 = FactoryBot.create(:group, course: course, sequential_id: 2)
      additional_group_2 = FactoryBot.create(:group, course: course, sequential_id: 3)

      delete :destroy, params: { id: group.id }

      expect(Group.exists?(group.id)).to be_falsey
      expect(additional_group_1.reload.sequential_id).to eq(1) 
      expect(additional_group_2.reload.sequential_id).to eq(1)
      expect(response).to redirect_to(course_path(course))
    end
  end
end
