# require_relative '../../spec/rails_helper'
# require_relative '../../spec/spec_helper'


# Add a declarative step here for populating the DB with movies.
Given /the following students exist/ do |students_table|
  students_table.hashes.each do |student|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    Student.create(name: student[:name], email: student[:email], email_old: student[:email_old], password: student[:password], bio: student[:bio], instructor: student[:instructor])
  end
end

And /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Course.create(name: course[:name], course_id: course[:course_id], course_code: course[:course_code], max_group_size: course[:max_group_size], semester: course[:semester], year: course[:year], instructor_id: course[:instructor_id])
  end
end

And /the following enrollments exist/ do |enrollments_table|
  enrollments_table.hashes.each do |enrollment|
    Enrollment.create(student_id: enrollment[:student_id], course_id: enrollment[:course_id])
  end
end

And /the following groups exist/ do |groups_table|
  groups_table.hashes.each do |group|
    Group.create(group_id: group[:group_id].to_i, course_id: group[:course_id].to_i, group_owner_id: group[:group_owner_id].to_i)
  end
end

And /the following group members exist/ do |group_members_table|
  group_members_table.hashes.each do |member|
    GroupMember.create(group_id: member[:group_id], student_id: member[:student_id])
  end
end

And /the following group requests exist/ do |group_requests_table|
  group_requests_table.hashes.each do |group_request|
    GroupRequest.create(student_id: group_request[:student_id].to_i, course_id: group_request[:course_id].to_i, group_id: group_request[:group_id].to_i)
  end
end

And /the following merge group requests exist/ do |merge_group_requests_table|
  merge_group_requests_table.hashes.each do |merge_group_request|
    MergeGroupRequest.create(group_requesting_id: merge_group_request[:group_requesting_id].to_i, group_to_merge_id: merge_group_request[:group_to_merge_id].to_i, course_id: merge_group_request[:course_id].to_i)
  end
end
  
Then /(.*) seed students should exist/ do | n_seeds |
  expect(Student.count).to eq n_seeds.to_i
end

Then /(.*) seed groups should exist/ do | n_seeds |
  expect(Group.count).to eq n_seeds.to_i
end

Then /(.*) seed courses should exist/ do | n_seeds |
  expect(Course.count).to eq n_seeds.to_i
end

Then /(.*) seed enrollments should exist/ do | n_seeds |
  expect(Enrollment.count).to eq n_seeds.to_i
end

Then /(.*) seed group requests should exist/ do | n_seeds |
  expect(GroupRequest.count).to eq n_seeds.to_i
end


And /I am logged in with email "(.+)" and password "(.+)"/ do |email, password|
  visit '/'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end


And /I am enrolled in "(.+)"/ do |course_name|
  course = Course.find_by(name: course_name)
  visit '/'
  fill_in "Course ID", with: course.course_id
  click_button "Join"
end
  
  # Make sure that one string (regexp) occurs before or after another one
  #   on the same page
  
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match(/#{e1}.*#{e2}/m)
end


  
Then /^I should (not )?see the following students: (.*)$/ do |no, student_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/
  students = student_list.split(", ")
  students.each do |student|
    if no
      expect(page).not_to have_content(student)
    else
      expect(page).to have_content(student)
    end
  end
end
  
Then /I should see all the students/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page).to have_xpath('//tr', count: Student.count + 1)
end
  
When /I press the "(.+)" button/ do |button|
  click_button(button)
end
  

When /I follow my group link "(.+)"/ do |group_id|
  within("#my-groups-container") do
    visit group_path(group_id)
  end
end

When /I follow class group link "(.+)"/ do |group_id|
  within("#class-groups-container") do
    visit group_path(group_id)
  end
end

When /I follow course link "(.+)"/ do |course_name|
  course = Course.find_by(name: course_name)
  visit course_path(course)
end
  
  ### Utility Steps Just for this assignment.
  
Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"; byebug
  1 # intentionally force debugger context in this method
end
  
Then /^debug javascript$/ do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end
  
  
Then /complete the rest of of this scenario/ do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  fail "Remove this step from your .feature files"
end
