require 'rails_helper'

RSpec.describe GroupRequest, type: :model do
  # Test for associations
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:group) }
    it { should belong_to(:course).optional }
  end

  # Test for validations
  describe 'validations' do
    it { should validate_presence_of(:student_id) }
    it { should validate_presence_of(:group_id) }

  end

  # Test for any custom methods in GroupRequest model
  describe 'custom methods' do
    it 'returns the correct status of the request' do
      group_request = FactoryBot.create(:group_request)
      expect(group_request.request_status).to eq('pending') 
    end
  end
end
