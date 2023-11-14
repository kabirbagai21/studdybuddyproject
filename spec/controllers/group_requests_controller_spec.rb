require 'rails_helper'

RSpec.describe GroupRequestsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:group) { FactoryBot.create(:group) }
  let(:student) { FactoryBot.create(:student) }
  let(:course) { FactoryBot.create(:course) }
  let(:group_request) { FactoryBot.create(:group_request, group: group, student: student, course: course) }

  before do
    sign_in student
  end

  describe 'POST #new' do
    context 'when the student has already requested to join the group' do
      before do
        FactoryBot.create(:group_request, group: group, student: student, course: course)
      end
    
      it 'redirects to the group path with an alert' do
        post :new, params: { group_id: group.id, student_id: student.id, course_id: course.id }
        expect(response).to redirect_to(group_path(group))
        expect(flash[:alert]).to eq('You have already requested to join. Please wait for someone in the group to approve your request')
      end
    end

    context 'when the student is already in a group for the course' do
      before do
        FactoryBot.create(:group, students: [student], course: course)
      end
  
      it 'redirects with an alert that the student is already in a group for this course' do
        post :new, params: { group_id: group.id, student_id: student.id, course_id: course.id }
        expect(response).to redirect_to(group_path(group))
        expect(flash[:alert]).to eq("You are already in a group for this course. Please leave the group you are in to request to join another.")
      end
    end

    context 'when the student is requesting to join multiple groups' do
    let(:another_group) { FactoryBot.create(:group, course: course) }

    before do
      FactoryBot.create(:group_request, student: student, course: course)

      post :new, params: { group_id: another_group.id, student_id: student.id, course_id: course.id }
    end

    it 'redirects and sets the expected flash notice' do
      expect(response).to redirect_to(group_path(another_group))
      expect(flash[:notice]).to eq("Requested to Join")
    end
  end

  end

  describe 'PATCH #approve' do
    it 'approves the request and redirects to the group path' do
      patch :approve, params: { id: group.id, student_id: student.id }
      expect(response).to redirect_to(group_path(group))
    end
  end


  describe 'DELETE #destroy' do
    it 'destroys the group request and redirects' do
      request_to_destroy = FactoryBot.create(:group_request, group: group, student: student, course: course)
      
      delete :destroy, params: { id: request_to_destroy.id, group_id: group.id, student_id: student.id }
      
      expect(response).to redirect_to(group_path(group))
      expect(flash[:notice]).to eq('Request Canceled.')
      
      expect(GroupRequest.exists?(request_to_destroy.id)).to be false
    end
  end

end
