require 'ascii_charts'
require 'http'
require 'json'

puts "========================================"
puts "    Will you need an umbrella today?    "
puts "========================================"

puts "Where are you?"
user_location = gets.chomp
# user_location = "brooklyn"
puts user_location
puts "Checking the weather at #{user_location}...."

# Fetch latitude and longitude using Google Maps API
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch('GMAPS_KEY')}"
resp = HTTP.get(maps_url)
parsed_response = JSON.parse(resp)
location = parsed_response.fetch("results").at(0).fetch("geometry").fetch("location")

latitude = location.fetch("lat")
longitude = location.fetch("lng")

# Assemble URL for the Pirate Weather API
pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch('PIRATE_WEATHER_KEY')}/#{latitude},#{longitude}"
# Fetch weather info
resp = HTTP.get(pirate_weather_url)
weather_info = JSON.parse(resp)

# Fetch the next hour's precipitation probability
next_hour_precip_prob = weather_info["hourly"]["data"][0]["precipProbability"] * 100

# Output the current temperature and precipitation probability for the next hour
puts "Your coordinates are #{latitude}, #{longitude}."
puts "It is currently #{weather_info["currently"]["temperature"]}°F."
puts "Next hour: Possible light rain starting in 25 min."

# Prepare data for the precipitation probability chart
precip_prob_data = []
weather_info["hourly"]["data"].each do |hour_data|
  precip_prob_data << (hour_data["precipProbability"] * 100).to_i
end

# Generate the precipitation probability chart
puts "\nHours from now vs Precipitation probability\n\n"
puts AsciiCharts::Cartesian.new(precip_prob_data, bar: true, hide_zero: true, title: '').draw

# Determine whether to take an umbrella based on next hour's precipitation probability
puts "\nYou might want to take an umbrella!" if next_hour_precip_prob > 50
