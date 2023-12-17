require 'rails_helper'

RSpec.describe MergeGroupRequestsController, type: :controller do
  let(:course) { FactoryBot.create(:course, max_group_size: 3) }
  let(:requesting_group) { FactoryBot.create(:group, course: course) }
  let(:group_to_merge) { FactoryBot.create(:group, course: course) }
  let(:merge_group_request) { FactoryBot.create(:merge_group_request, group_requesting: requesting_group, group_to_merge: group_to_merge, course: course) }

  before do
    FactoryBot.create(:student, groups: [requesting_group])
    FactoryBot.create(:student, groups: [group_to_merge])
  end

  describe 'GET #new' do
    context 'when merge exceeds maximum group size' do
      before { 3.times { FactoryBot.create(:student, groups: [group_to_merge]) } }

      it 'redirects with an alert' do
        get :new, params: { group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
        expect(response).to redirect_to(group_path(group_to_merge))
        expect(flash[:alert]).to match('Merging with this group would exceed the maximum allowed group size for this course')
      end
    end

    context 'when a merge request already exists' do
      before { merge_group_request }

      it 'redirects with an alert about existing request' do
        get :new, params: { group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
        expect(response).to redirect_to(group_path(group_to_merge))
        expect(flash[:alert]).to match('You have already requested to join. Please wait for someone in the group to approve your request')
      end
    end

    context 'when requesting group has multiple pending requests' do
      before do
        2.times { FactoryBot.create(:merge_group_request, group_requesting: requesting_group, group_to_merge: FactoryBot.create(:group, course: course), course: course) }
        get :new, params: { group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
      end
  
      it 'redirects with the appropriate notice' do
        expect(response).to redirect_to(group_path(group_to_merge))
        
        expect(flash[:notice]).to match('Requested to Join')
      end
    end
  end


  describe 'POST #approve' do
    let(:merge_group_request) { FactoryBot.create(:merge_group_request, group_requesting: requesting_group, group_to_merge: group_to_merge, course: course) }

    context 'when merge is approved' do
      before do
        post :approve, params: { id: merge_group_request.id, group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
      end

      it 'merges the groups and redirects' do
        expect(response).to redirect_to(group_path(group_to_merge))
        expect(Group.find_by(id: requesting_group.id)).to be_nil
        expect(group_to_merge.students.count).to eq(2)
      end
    end

    context 'when merge is not valid due to group size' do
      before do
        3.times { FactoryBot.create(:student, groups: [requesting_group]) }
        merge_group_request
        post :approve, params: { id: merge_group_request.id, group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
      end
  
      it 'redirects with an alert' do
        expect(response).to redirect_to(group_path(group_to_merge))
        expect(flash[:alert]).to match('Merging with this group would exceed the maximum allowed group size for this course')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:merge_group_request) { FactoryBot.create(:merge_group_request, group_requesting: requesting_group, group_to_merge: group_to_merge, course: course) }

    context 'when a merge request is canceled' do
      before do
        delete :destroy, params: { id: merge_group_request.id, group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
      end

      it 'destroys the merge request and redirects' do
        expect(response).to redirect_to(group_path(group_to_merge))
        expect(flash[:notice]).to match('Request Canceled.')
        expect(MergeGroupRequest.find_by(id: merge_group_request.id)).to be_nil
      end
    end

    context 'when a merge request does not exist' do
      it 'handles the scenario appropriately' do
        expect {
          delete :destroy, params: { id: 0, group_requesting_id: requesting_group.id, group_to_merge_id: group_to_merge.id, course_id: course.id }
        }.not_to change(MergeGroupRequest, :count)
      end
    end
  end
end
