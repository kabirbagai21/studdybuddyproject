# require_relative '../../spec/rails_helper'
# require_relative '../../spec/spec_helper'


# Add a declarative step here for populating the DB with movies.
Given /the following students exist/ do |students_table|
  students_table.hashes.each do |student|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    Student.create(name: student[:name], email: student[:email], email_old: student[:email_old], password: student[:password], bio: student[:bio])
  end
end

And /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Course.create(name: course[:name], course_id: course[:course_id])
  end
end
  
Then /(.*) seed students should exist/ do | n_seeds |
  expect(Student.count).to eq n_seeds.to_i
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
