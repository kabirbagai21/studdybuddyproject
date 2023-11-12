FactoryBot.define do
    factory :student do
      sequence(:name) { |n| "John Doe #{n}" }
      sequence(:email) { |n| "john#{n}@example.com" }
      password { "password" }
      bio { "Student Bio" }
    end
  
    factory :course do
      sequence(:name) { |n| "Course #{n}" }
    end
  
    factory :group do
      association :course
      group_owner_id { FactoryBot.create(:student).id }
    end
  end
