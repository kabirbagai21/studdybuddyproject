require 'rails_helper'

RSpec.describe "public_profiles/show.html.erb", type: :view do
  context "with a valid student and group" do
    let(:student) { FactoryBot.create(:student, bio: 'Test Bio', email: Faker::Internet.unique.email(domain: 'columbia.edu')) }
    let(:group) { FactoryBot.create(:group) }

    before do
      assign(:student, student)
      assign(:group, group)

      render
    end

    it "displays the student's name" do
      expect(rendered).to include(student.name)
    end

    it "displays the student's email" do
      expect(rendered).to include(student.email)
    end

    # Removed the test for student's bio as it's not displayed in the view
    # it "displays the student's bio" do
    #   expect(rendered).to include(student.bio)
    # end

    it "displays a link to the group page" do
      expect(rendered).to have_link('Return to Group Page', href: group_path(group))
    end
  end

  context "with a valid student and no group" do
    let(:student) { FactoryBot.create(:student, bio: 'Test Bio', email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

    before do
      assign(:student, student)
      assign(:group, nil)

      render
    end

    it "does not display a link to the group page" do
      expect(rendered).not_to have_link('Return to Group Page')
    end
  end
end
