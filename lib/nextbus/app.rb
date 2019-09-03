module NextBus
  class App
    SVC = 'http://svc.metrotransit.org/NexTrip/'

    def run
      args = validate_args()
      @api = NextBus::Api.new

      route_num = @api.get_route(args[0])
      direction_num = @api.get_direction(args[2], route_num)
      stop_num = @api.get_stops(args[1], route_num, direction_num)
      departure_time = @api.get_next_departure(route_num, direction_num, stop_num)
      
      puts calc_departure(departure_time)
      exit
    end

    def validate_args()
      if ARGV.include? '-h' || '--help'
        abort('Example usage: nextbus "960" "State Fair" "East"')
      elsif ARGV.length < 3 || ARGV.length > 3 
        abort("Invalid number of arguments")
      else 
        return ARGV.first(3)
      end
    end

    def calc_departure(departure_time)
      seconds = departure_time.to_i - Time.now.utc.to_i
      hours = seconds / 3600
      minutes = seconds / 60 % 60 + 1 # MetroTransit's departure text adds 1 minute
      return hours.nonzero? ? "#{hours} hours, #{minutes} minutes" : "#{minutes} minutes"
    end
 
  end
end

