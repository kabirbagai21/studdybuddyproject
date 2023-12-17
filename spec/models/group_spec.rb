require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:course) { FactoryBot.create(:course) }
  let(:student) { FactoryBot.create(:student, email: Faker::Internet.unique.email(domain: 'columbia.edu')) }

  describe 'sequential_id functionality' do
    it 'assigns a sequential_id to a new group' do
      group = Group.create(course: course)
      expect(group.sequential_id).to eq(1)
    end

    it 'recalculates sequential_id after a group is destroyed' do
      group1 = Group.create(course: course)
      group2 = Group.create(course: course)
      sequential_id_before = group2.sequential_id
      group1.destroy
      group2.reload
      expect(group2.sequential_id).to be < sequential_id_before
    end

    context 'when groups are merged' do
      it 'correctly recalibrates sequential_id after a merge' do
        group1 = Group.create(course: course)
        group2 = Group.create(course: course)
        group2.destroyed_for_merge = true
        group2.destroy
        group1.reload
        expect(group1.sequential_id).to eq(1)
      end
    end

    context 'when group is destroyed with merge flag' do
      it 'skips recalibration when destroyed_for_merge is set' do
        group1 = Group.create(course: course)
        group2 = Group.create(course: course)
        sequential_id_before = group2.sequential_id
        group1.destroyed_for_merge = true
        group1.destroy
        group2.reload
        expect(group2.sequential_id).to eq(sequential_id_before)
      end
    end
  end

  describe 'group_id functionality' do
    it 'assigns a unique group_id to a new group' do
      group = Group.create(course: course)
    end
  end

  describe 'one_group_per_student validation' do
    it 'prevents creating more than one group per student in a course' do
      Group.create(course: course, group_owner_id: student.id)
      new_group = Group.new(course: course, group_owner_id: student.id)
      expect(new_group).not_to be_valid
      expect(new_group.errors[:group_owner_id]).to include("can't create more than one group")
    end
  end
end
