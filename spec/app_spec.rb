require "nextbus"

RSpec.describe NextBus::App do

  describe "#validate_args" do
    it "returns 3 command line args" do
      ARGV = ['route', 'stop', 'direction']
      app = NextBus::App.new
      args = app.validate_args()
      expect(args).to eq(['route', 'stop', 'direction'])
    end
  end

  describe "#calc_departure" do
    it "returns next departure time" do
      ten_min = Time.now.utc.to_i + 60*9
      departure = NextBus::App.new.calc_departure(ten_min)
      expect(departure).to eq("10 minutes")
    end
  end
  
end