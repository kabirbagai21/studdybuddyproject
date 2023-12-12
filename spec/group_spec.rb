require 'rails_helper'

describe 'Group' do
  let(:course) { FactoryBot.create(:course) }
  let(:student1) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }
  let(:student2) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

  it 'contains valid attributes' do
    group = Group.new(course: course)
    expect(group).to be_valid
  end

  it 'is not valid without a course_id' do
    group = Group.new
    expect(group).to_not be_valid
  end

  it 'belongs to a course' do
    group = course.groups.create
    expect(group.course).to eq(course)
  end

  it 'can have and belong to many students' do
    group = Group.create(course: course)
    group.students << student1
    group.students << student2
    expect(group.students).to include(student1, student2)
  end

  describe 'Group creation' do
    it 'allows a user to create a group' do
      group = Group.create(course: course, group_owner_id: student1.id)
      expect(group).to be_valid
    end

    it 'does not allow a user to create more than one group' do
      Group.create(course: course, group_owner_id: student1.id)
      second_group = Group.new(course: course, group_owner_id: student1.id)
      expect(second_group).not_to be_valid
    end

    it 'sets the group owner correctly' do
      group = Group.create(course: course, group_owner_id: student1.id)
      expect(group.group_owner_id).to eq(student1.id)
    end
  end
end
