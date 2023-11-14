require 'rails_helper'

RSpec.describe GroupRequestsController, type: :request do
let(:course) { FactoryBot.create(:course) }
let(:group) { FactoryBot.create(:group, course: course) }
let(:student) { FactoryBot.create(:student) }

describe 'PATCH /group_requests/:id/approve' do
  let(:group_request) { FactoryBot.create(:group_request, group: group, student: student, course: course) }

  context 'when approving a group request' do
    before do
      patch approve_group_request_path(group_request), params: { student_id: student.id }
    end

    it 'adds the student to the group' do
      group.reload
      expect(group.students).to include(student)
    end

    it 'deletes the group request' do
      expect(GroupRequest.exists?(group_request.id)).to be_falsey
    end

    it 'redirects to the group path' do
      expect(response).to redirect_to(group_path(group))
    end
  end
end


end
