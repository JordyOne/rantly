require 'rails_helper'
require 'bcrypt'

describe User do

  before(:each) do
    @user_1 = create_user
    @user_2 = create_user
  end

  it "can create a valid user" do
    expect(create_user).to be_valid
  end

  it "responds to follower_id" do
    relationship = create_relationship
    expect(relationship).to respond_to(:follower_id)
  end

  it "responds to followed_id" do
    relationship = create_relationship
    expect(relationship).to respond_to(:followed_id)
  end

  it "responds to created_at" do
    relationship = create_relationship
    expect(relationship).to respond_to(:created_at)
  end

  it "responds to updated_at" do
    relationship = create_relationship
    expect(relationship).to respond_to(:updated_at)
  end

  it "should create a new instance given a valid attribute" do
    create_relationship(follower_id: @user_1, followed_id: @user_2)
  end

  it "should require a follower_id" do
    no_follower_id_relationship = create_relationship(:follower_id => "")
    expect(no_follower_id_relationship).to_not be_valid
  end

  it "should require a followed_id" do
    no_followed_id_relationship = create_relationship(:followed_id => "")
    expect(no_followed_id_relationship).to_not be_valid
  end

  it "should has a created_at timestamp" do
    relationship_with_timestamp = create_relationship
    expect(relationship_with_timestamp.created_at).to be_a(Time)
  end

  it "should has an updated_at timestamp" do
    relationship_with_timestamp = create_relationship
    expect(relationship_with_timestamp.updated_at).to be_a(Time)
  end

  it "should have an integar for followed_id" do
    relationship = create_relationship
    expect(relationship.followed_id).to be_a(Integer)
  end

  it "should have an integar for follower_id" do
    relationship = create_relationship
    expect(relationship.follower_id).to be_a(Integer)
  end
end



