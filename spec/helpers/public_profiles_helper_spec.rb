require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PublicProfilesHelper. For example:
#
# describe PublicProfilesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PublicProfilesHelper, type: :helper do
  describe '#format_profile_data' do
    it 'formats the profile data correctly' do
      profile_data = { name: 'John Doe', email: 'john@example.com' }
      formatted_data = helper.format_profile_data(profile_data)
      expect(formatted_data).to eq('Name: John Doe, Email: john@example.com')
    end
  end


end
