require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url_address = @street_address.gsub(" ", "+")
  
    url_maps = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_address

    parsed_maps_data = JSON.parse(open(url_maps).read)
  
    @latitude = parsed_maps_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_maps_data["results"][0]["geometry"]["location"]["lng"]
    
    
    
    url_weather = "https://api.darksky.net/forecast/4624212b1270cc4fc38ed5cd853ed0e1/" + @latitude.to_s + "," + @longitude.to_s
    
    parsed_weather_data = JSON.parse(open(url_weather).read)
    
    

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
