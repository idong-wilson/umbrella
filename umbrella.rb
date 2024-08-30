require "http"
require "json"

pp "Hello there!"

pp "Where are you at the moment?"

user_location = gets.chomp

# user_location = "Chicago"

pp user_location

#Using Google Maps API, fetch the latitude and longitude

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)

raw_resp = resp.to_s

parsed_resp = JSON.parse(raw_resp)

results = parsed_resp.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

pp latitude = loc.fetch("lat")
pp longitude = loc.fetch("lng")


# Take the lat/lng
# Assemble the correct URL for the Pirate Weather API
# Get it, parse it, and dig out current temperature


# Assemble the Pirate Weather API URL

pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"
# pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}?units=si"

# Make a request to the Pirate API and parse the response

weather_resp = HTTP.get(pirate_weather_url)
weather_data = JSON.parse(weather_resp.to_s)

# Dig out current temperature

current_temp = weather_data.dig("currently", "temperature")

pp "The current temperature at #{user_location} is #{current_temp}°F"
