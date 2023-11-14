module PublicProfilesHelper
    def format_profile_data(data)
      "Name: #{data[:name]}, Email: #{data[:email]}"
    end

  end
