# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name
  
      when /^the (StudyBuddy )?home\s?page$/ then '/students'
      #when /^the movies page$/ then '/movies'

      when /^the profile page for "(.+)"/ then '/'
        #student = Student.find_by(name: $1)
        #profile_page_url = student_path(student)
        #puts "Generated URL: #{profile_page_url}"
        #student_path(student)

      when /^the edit page for "(.+)"/
        student = Student.find_by(name: $1)
        edit_student_path(student)

      when /^the course page for "(.+)"/
        course = Course.find_by(name: $1)
        course_path(course)

      when /^the sign in page/
        new_student_session_path

      when /^the sign up page/
        new_student_registration_path
  
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
  
      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)