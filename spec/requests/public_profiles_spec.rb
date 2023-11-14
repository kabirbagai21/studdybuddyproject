require 'rails_helper'

RSpec.describe "PublicProfiles", type: :request do
  describe "GET /show" do
    it "returns http success" do
      student = Student.create!(name: "John Doe", email: "john@example.com", password: "password", encrypted_password: "password")
      course = Course.create!(name: "Sample Course")  
      group = Group.create!(course_id: course.id)     

      get public_profile_show_path(id: student.id, group_id: group.id)
      expect(response).to have_http_status(:success)
    end
  end
end
