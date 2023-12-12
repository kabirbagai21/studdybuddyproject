require 'rails_helper'

RSpec.describe PublicProfilesController, type: :controller do
  describe "GET /show" do
    context "with a valid student id" do
      let(:student) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

      it "returns http success" do
        get :show, params: { id: student.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "with an invalid student id" do
      it "handles the error gracefully" do
        get :show, params: { id: 'invalid_id' }
        expect(response).to redirect_to(root_path) 
        expect(flash[:alert]).to match(/Student not found/)
      end
    end
  end
end
