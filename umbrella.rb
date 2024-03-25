puts "Hello!"
puts "Where are you located?"
# user_location = "Atlanta" # Manually set the location
user_location = gets.chomp
puts user_location

require "http"
require "json"
require "time"

# Fetch latitude and longitude using google maps API
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch('GMAPS_KEY')}"
resp = HTTP.get(maps_url)
parsed_response = JSON.parse(resp)
location = parsed_response.fetch("results").at(0).fetch("geometry").fetch("location")

latitude = location.fetch("lat")
longitude = location.fetch("lng")
puts "Geographical coordinates of #{user_location}: #{latitude}, #{longitude}"

# Assemble URL for the Pirate Weather API
pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch('PIRATE_WEATHER_KEY')}/#{latitude},#{longitude}"
# Fetch weather info
resp = HTTP.get(pirate_weather_url)
weather_info = JSON.parse(resp)

# Fetch the current temperature
current_temp = weather_info["currently"]["temperature"]
puts "The current temperature in #{user_location} is #{current_temp}°F"

# Display the summary of the weather for the next hour
next_hour_summary = weather_info["hourly"]["summary"]
puts "Weather summary for the next hour: #{next_hour_summary}"

# Check precipitation probability for the next twelve hours
umbrella_needed = false
for i in 1..12
  hour_info = weather_info["hourly"]["data"][i]
  precip_probability = hour_info["precipProbability"]
  if precip_probability > 0.1
    umbrella_needed = true
    puts "In the next #{i} hour(s), there is a #{(precip_probability * 100).round}% chance of precipitation."
  end
end

if umbrella_needed
  puts "You might want to carry an umbrella!"
else
  puts "You probably won't need an umbrella today."
end





# puts "Hi!"

# puts "What is your name?"

# user_name = gets.chomp

# puts "#{user_name}, Where are you?"

# user_location = gets.chomp

# # user_location = "Atlanta"

# # Fetch latitude and longitude using google maps API

# maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# require "http"

# resp = HTTP.get(maps_url)

# raw_response = resp.to_s

# require "json"

# parsed_response = JSON.parse(raw_response)

# results = parsed_response.fetch("results")

# first_result = results.at(0)

# geo = first_result.fetch("geometry")

# loc = geo.fetch("location")

# latitude = loc.fetch("lat")
# longitude = loc.fetch("lng")


# # Assemble URL for the Pirate Weather API

# pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch('PIRATE_WEATHER_KEY')}/#{latitude},#{longitude}"

# # From the Pirate Weather API, fetch weather info

# resp = HTTP.get(pirate_weather_url)

# weather_info = JSON.parse(resp)

# # Fetch the current temperature

# current_temp = weather_info["currently"]["temperature"]

# puts "The temperature at #{user_location} is currently #{current_temp}°F."

# # Show the summary of the weather for the next hour
# require "time"

# next_hour_summary = weather_info["hourly"]["summary"]

# puts "For the next hour, the sky will be: #{next_hour_summary}"

# #Check for precipitation level for the next 12 hours

# # Get the current hour in local time
# current_hour = Time.now.hour

# # Display the hourly forecast for the next twelve hours
# puts "Hourly forecast for the next twelve hours:"
# for i in 0..11
#   # Calculate the index of the forecast hour based on the current hour
#   forecast_hour_index = (current_hour + i) % 24
#   # Get the weather data for the forecast hour
#   hour_info = weather_info["hourly"]["data"].find { |data| Time.at(data["time"]).hour == forecast_hour_index }
#   hour_time = Time.at(hour_info["time"]).strftime("%l:%M %P") # Format time as "8:00 am", "9:00 am", etc.
#   precip_probability = hour_info["precipProbability"]
#   puts "#{hour_time}: #{(precip_probability * 100).round}% chance of precipitation."
# end






# take the lat/lng
# Assemble the correct url for the Pirate Weather API
# Det it, parse it, and dig out the current temperature



# # I've already created a string variable above: pirate_weather_api_key
# # It contains sensitive credentials that hackers would love to steal so it is hidden for security reasons.

# require "http"

# # Assemble the full URL string by adding the first part, the API token, and the last part together
# pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887,-87.6355"

# # Place a GET request to the URL
# raw_response = HTTP.get(pirate_weather_url)

# require "json"

# parsed_response = JSON.parse(raw_response)

# currently_hash = parsed_response.fetch("currently")

# current_temp = currently_hash.fetch("temperature")

# puts "The current temperature is " + current_temp.to_s + "."
