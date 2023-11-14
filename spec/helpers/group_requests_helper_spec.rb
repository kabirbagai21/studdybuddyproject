require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GroupRequestsHelper. For example:
#
# describe GroupRequestsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GroupRequestsHelper, type: :helper do
  describe '#format_request_status' do
    it 'returns "Pending Approval" for pending status' do
      expect(helper.format_request_status('pending')).to eq('Pending Approval')
    end

    it 'returns "Approved" for approved status' do
      expect(helper.format_request_status('approved')).to eq('Approved')
    end

    it 'returns "Unknown Status" for any other status' do
      expect(helper.format_request_status('rejected')).to eq('Unknown Status')
    end
  end
end
