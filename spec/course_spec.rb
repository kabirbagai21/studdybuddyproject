require_relative '../app/models/course.rb'

RSpec.describe Course, type: :model do
  let(:course) { Course.new(name: "Introduction to Rails") }

  describe "associations" do
    it "has many enrollments" do
      expect(course).to have_many(:enrollments)
    end

    it "has many students through enrollments" do
      expect(course).to have_many(:students).through(:enrollments)
    end
  end

  describe "validations" do
    it "is valid with a name" do
      expect(course).to be_valid
    end

    it "is not valid without a name" do
      course.name = nil
      expect(course).to_not be_valid
    end
  end
end





