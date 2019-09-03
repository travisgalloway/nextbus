class Route
  attr_accessor :description, :providerId, :route

  def initialize(description, providerId, route)
      self.description = description
      self.providerId = providerId
      self.route = route
  end
end