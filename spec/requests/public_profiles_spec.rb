require 'rails_helper'

RSpec.describe "PublicProfiles", type: :request do
  describe "GET /show" do
    it "returns http success" do
      student = Student.create!(name: "John Doe", email: "john@columbia.edu", password: "password")

      get public_profile_path(student)
      expect(response).to have_http_status(:success)
    end
  end
end
