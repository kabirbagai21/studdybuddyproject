# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
students = [{:name => 'Kabir', :email => 'kb3343@columbia.edu', password: '123456789', :bio => 'CS Major'}, {:name => 'Yuya', :email => 'yt2749@columbia.edu', password: '123456789', :bio => 'CS Major'}]
courses = [{:name => 'Engineering SaaS', :course_id => '4152', :max_group_size => 4}, {:name => 'AP', :course_id => '3157', :max_group_size => 2}]
students.each do |student|
    Student.create!(student)
  end

courses.each do |course|
    Course.create!(course)
  end

