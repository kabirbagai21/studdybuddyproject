require 'rails_helper'

RSpec.describe "PublicProfiles", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/public_profiles/show"
      expect(response).to have_http_status(:success)
    end
  end

end
