require 'rails_helper'
require 'bcrypt'

describe User do


  it "should create a new instance given a valid attribute" do
    create_user
  end

  it "should require a first name" do
    no_name_user = create_user(:first_name => "")
    expect(no_name_user).to_not be_valid
  end

  it "should require a last name" do
    no_name_user = create_user(:last_name => "")
    expect(no_name_user).to_not be_valid
  end

  it "should require a bio" do
    no_email_user = create_user(:bio => "")
    expect(no_email_user).to_not be_valid
  end

  it "should require a frequency" do
    no_email_user = create_user(:frequency => "")
    expect(no_email_user).to_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = create_user
    end

    it "should have a password attribute" do
      expect(@user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      @user = create_user(:password => "")
      expect(@user).to_not be_valid
    end

    describe "password encryption" do

      before(:each) do
        @user = create_user
      end

      it "should have an encrypted password attribute" do
        expect(@user).to respond_to(:password_digest)
      end

      it "should set the encrypted password attribute" do
        expect(@user.password_digest).to_not be_nil
      end

      describe "authenticate method" do

        it "should exist" do
          expect(@user).to respond_to(:authenticate)
        end

        it "should return nil on username/password mismatch" do
          expect(User.authenticate("User", "wrongpass")).to eq(nil)
        end

        it "should return nil for a username with no user" do
          expect(User.find_by(username: "not_a_username")).to eq(nil)
        end

        it "should return the user on username/password match" do
          user = User.authenticate("User", "password")
          expect(user).to eq(@user)
        end
      end
    end

    describe "admin attribute" do

      before(:each) do
        @user = create_user
      end

      it "should respond to admin" do
        expect(@user).to respond_to(:admin)
      end

      it "should not be an admin by default" do
        expect(@user.admin).to_not eq(true)
      end

      it "should be convertible to an admin" do
        @user.admin = true
        expect(@user.admin).to eq(true)
      end
    end

    describe "rant associations" do

      before(:each) do
        # Create user and two rants
        @user = create_user!
        @rant_1 = create_rant(user_id: @user.id)
        @rant_2 = create_rant(user_id: @user.id)
      end

      it "should have a rants attribute" do
        expect(@user).to respond_to(:rants)
      end

      it "should order rants by reverse time" do
        expect(@user.rants).to eq([@rant_1, @rant_2])
      end

      it "should destroy associated rants" do
        @user.destroy
        expect { Rant.find(@rant_1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end

  describe "relationships" do

    before(:each) do
      @user = create_user
      @followed = create_user
    end

    it "should have a relationships method" do
      expect(@user).to respond_to(:relationships)
    end

    it "should have a following method" do
      expect(@user).to respond_to(:following)
    end

    it "should follow another user" do
      @user.follow!(@followed)
      expect(@user.following).to include(@followed)
    end

    it "should include the followed user in the following array" do
      @user.follow!(@followed)
      expect(@user.following).to include(@followed)
    end

    it "should have an unfollow! method" do
      expect(@user).to respond_to(:unfollow!)
    end

    it "should unfollow a user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      expect(@user.following).to_not include(@followed)
    end

    it "should have a reverse_relationships method" do
      expect(@user).to respond_to(:reverse_relationships)
    end

    it "should have a followers method" do
      expect(@user).to respond_to(:followers)
    end

    it "should include the follower in the followers array" do
      @user.follow!(@followed)
      expect(@followed.followers).to include(@user)
    end
  end
end


