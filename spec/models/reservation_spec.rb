require 'spec_helper'

describe Reservation do
  it "has an email address" do
    this = Reservation.new
    this.should_not be_valid
  end

  # it "has a requested date and time" do
  #   this = Reservation.new()
end
