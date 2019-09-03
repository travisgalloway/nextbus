require 'webmock/rspec'
require "nextbus"

RSpec.describe NextBus::Api do

  describe "#get_route" do
    it "returns route from api" do
      body = '[{"Description":"960 - State Fair - Ltd Stop - Minneapolis - State Fair","ProviderID":"8","Route":"960"}]'
      stub = stub_request(:get, "http://svc.metrotransit.org/NexTrip/Routes?format=json").
         to_return(:status => 200, :body => body, :headers => {})

      route = NextBus::Api.new.get_route('960 - State Fair')
      
      expect(stub).to have_been_requested
      expect(route).to eq('960')
    end
  end

  describe "#get_direction" do
    it "returns direction from api" do
      body = '[{"Text":"EASTBOUND","Value":"2"}]'
      stub = stub_request(:get, "http://svc.metrotransit.org/NexTrip/Directions/960?format=json").
         to_return(:status => 200, :body => body, :headers => {})

      direction = NextBus::Api.new.get_direction('East', 960)
      
      expect(stub).to have_been_requested
      expect(direction).to eq('2')
    end
  end

  describe "#get_stops" do
    it "returns route from api" do
      body = '[{"Text":"State Fair ","Value":"FAIR"}]'
      stub = stub_request(:get, "http://svc.metrotransit.org/NexTrip/Stops/960/2?format=json").
         to_return(:status => 200, :body => body, :headers => {})

      stop = NextBus::Api.new.get_stops('State Fair', 960, 2)
      
      expect(stub).to have_been_requested
      expect(stop).to eq('FAIR')
    end
  end

  describe "#get_stops" do
    it "returns stops from api" do
      body = '[{"Text":"State Fair ","Value":"FAIR"}]'
      stub = stub_request(:get, "http://svc.metrotransit.org/NexTrip/Stops/960/2?format=json").
         to_return(:status => 200, :body => body, :headers => {})

      stop = NextBus::Api.new.get_stops('State Fair', 960, 2)
      
      expect(stub).to have_been_requested
      expect(stop).to eq('FAIR')
    end
  end

  describe "#get_next_departure" do
    it "returns departures from api" do
      body = '[{"DepartureText":"4:03","DepartureTime":"/Date(1567890000000-0500)/"}]'
      stub = stub_request(:get, "http://svc.metrotransit.org/NexTrip/960/2/FAIR?format=json").
         to_return(:status => 200, :body => body, :headers => {})

      departure = NextBus::Api.new.get_next_departure(960, 2, 'FAIR')
      
      expect(stub).to have_been_requested
      expect(departure).to eq(1567890000)
    end
  end
end