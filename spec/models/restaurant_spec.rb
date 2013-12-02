require 'spec_helper'

describe Restaurant do 
  it "is not valid without name" do
    subway = Restaurant.new
    subway.should_not be_valid
  end

  it "is not valid without address" do
    subway = Restaurant.new(name:"subway")
    subway.should_not be_valid
  end

  it "should have an address longer than 4 characters" do
    subway = Restaurant.new(name:"subway", address:"123")
    subway.should_not be_valid
  end

  it "should respond to .name" do
    subway = Restaurant.new(name:"subway")
    subway.should respond_to(:name)
  end

  it "should have a name that matches 'subway'" do
    subway = Restaurant.new(name:'subway')
    subway.name.should match(/subway/)
  end

  it "has a phone number" do
    subway = Restaurant.new(name:"subway", address:"123 fake ln",
    description:"sandwich shop", phone_number:"382-837-9382")
    subway.phone_number.should be_true
  end

  it "has phone number at least 10 characters long" do
    subway = Restaurant.new(name:'subway', address:'123 fake ln',
    description:'sandwich shop', phone_number:'12345' )
    subway.should_not be_valid
  end

  it "has an owner" do
    subway = Restaurant.new(name:"subway")
    me = Owner.new
    me.name = 'jerome'
    me.email = 'test@testemail.com'
    me.password = 'abc123456'
    subway.owner = me
    me.save!
    subway.owner.name.should be == 'jerome'
  end
end

describe Owner do
  it "is not valid without name" do
    jerome = Owner.new
    jerome.should_not be_valid
  end

  it "has an email address" do
    jerome = Owner.new(name:"jerome", email:"jerome@test.com")
    jerome.should respond_to(:email)
  end
end


