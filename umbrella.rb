puts "Hi!"

puts "What is your name?"

user_name = gets.chomp

puts "#{user_name}, where are you located?"

user_location = gets.chomp

# user_location = "Atlanta"

# Fetch latitude and longitude using google maps API

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

require "http"

resp = HTTP.get(maps_url)

raw_response = resp.to_s

require "json"

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")


# Assemble URL for the Pirate Weather API

pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch('PIRATE_WEATHER_KEY')}/#{latitude},#{longitude}"

# From the Pirate Weather API, fetch weather info

resp = HTTP.get(pirate_weather_url)

weather_info = JSON.parse(resp)

# Fetch the current temperature

current_temp = weather_info["currently"]["temperature"]

puts "The temperature at #{user_location} is currently #{current_temp}°F."

# Show the summary of the weather for the next hour
require "time"

next_hour_summary = weather_info["hourly"]["summary"]

puts "For the next hour, the sky will be: #{next_hour_summary}"

#Check for precipitation level for the next 12 hours

umbrella_needed = false
for i in 0..11

  hour_info = weather_info["hourly"]["data"][i]

  hour_time = Time.at(hour_info["time"]).strftime("%l:%M %P")

  precip_probability = hour_info["precipProbability"]

  if precip_probability > 0.1

    umbrella_needed = true

    puts "In #{hour_time}, there's a #{(precip_probability * 100).round}% chance of precipitation."

  end

end

if umbrella_needed

  puts "You might want to carry an umbrella!"

else

  puts "You probably won't need an umbrella today."
  
end




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
