require 'net/http'
require 'json'

module NextBus
  class Api
    SVC = 'http://svc.metrotransit.org/NexTrip/'

    def get_route(route_desc)
      data = get("#{SVC}Routes?format=json")    
      routes = data.map { |r| Route.new(r['Description'], r['ProviderID'], r['Route']) } 
      req_route = routes.select { |r| r.description.downcase.include?(route_desc.downcase) }
      
      if req_route.count > 1
        puts "Multiple routes for '#{route_desc}' found:"
        req_route.each { |r| puts r.description }
        exit
      end

      return req_route ? req_route.first.route : abort("Requested route not found")
    end
    
    def get_direction(direction_desc, route_num)
      data = get("#{SVC}Directions/#{route_num}?format=json")
      directions = data.map { |d| Direction.new(d['Text'], d['Value']) }
      req_direction = directions.select { |d| d.text.downcase.include?(direction_desc.downcase) }.first
      return req_direction ? req_direction.value : abort("Requested direction not found")
    end
    
    def get_stops(stop_desc, route_num, direction_num)
      data = get("#{SVC}Stops/#{route_num}/#{direction_num}?format=json")
      stops = data.map { |s| Stop.new(s['Text'], s['Value']) }
      req_stop = stops.select { |s| s.text.downcase.include?(stop_desc.downcase) }

      if req_stop.count > 1
        puts "Multiple stops for '#{stop_desc}' found:"
        req_stop.each { |s| puts s.text }
        exit
      end

      return req_stop ? req_stop.first.value : abort("Requested stop not found")
    end
    
    def get_next_departure(route_num, direction_num, stop_num)
      data = get("#{SVC}#{route_num}/#{direction_num}/#{stop_num}?format=json")
      departures = data.map { |d| Departure.new(d['DepartureText'], d['DepartureTime']) }
      req_departure = departures.sort_by {|d| d.departure_time }.first
      return req_departure ? req_departure.departure_time : abort("") # Return nothing if no scheduled departures
    end
    
    def get(uri)
      uri = URI(uri)
      res = Net::HTTP.get_response(uri)
    
      if res.is_a?(Net::HTTPSuccess)
        return JSON.parse(res.body)
      else
        abort("Request to MetroTransit API failed")
      end
    end   
  end
end