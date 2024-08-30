require "http"
require "json"

pp "Hello there!"

pp "Where are you at the moment?"

user_location = gets.chomp

# user_location = "Chicago"

pp user_location

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
