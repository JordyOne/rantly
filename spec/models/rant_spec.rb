require 'rails_helper'
require 'bcrypt'

describe Rant do

  before(:each) do
    @rant = create_rant
  end
  it "can create a valid rant" do
    create_rant
  end

  it "will not except a rant less than 140" do
    rant = create_rant(text: "too short")
    expect(rant).to_not be_valid
  end

  it "will not except a title over 50 characters" do
    rant = create_rant(title: "This is a rant titlle that is far too long" +
                                "It is far in excess of the 50 character limit" +
                                "What kind of title is this anyways?")
    expect(rant).to_not be_valid
  end

  it "responds to text" do
    expect(@rant).to respond_to(:text)
  end

  it "responds to title" do
    expect(@rant).to respond_to(:title)
  end


end