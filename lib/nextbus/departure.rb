class Departure
  attr_accessor :departure_text, :departure_time

  def initialize(departure_text, departure_time)
      self.departure_text = departure_text
      self.departure_time = departure_time[/\((.*?)-/,1][0..9].to_i
  end
end