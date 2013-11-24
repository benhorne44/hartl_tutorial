require 'spec_helper'

describe User do

  before {@user = FactoryGirl.build(:user)}

  it "should have a name attribute" do
    expect(@user).to respond_to(:name)
  end

  it "should have an email attribute" do
    expect(@user).to respond_to(:email)
  end

  it "should be a valid user" do
    expect(@user).to be_valid
  end

  it "a user should be not be valid without name" do
    user1 = FactoryGirl.build(:user, name: "")
    expect(user1).to_not be_valid
  end

  it "a user is invalid with an invalid email" do
    addresses = ['user@foo,com', 'user_at_foo.org', 'example.user@foo.',
                 'foo@bar_baz.com', 'foo@bar+baz.com', 'foo@bar..com']
    addresses.each do |invalid_address|
      user1 = FactoryGirl.build(:user, email: invalid_address)
      expect(user1).to_not be_valid
    end
  end

  it "an email must be unique" do
    @user.save
    user1 = FactoryGirl.build(:user, email: @user.email)
    expect(user1).to_not be_valid
  end

  it "an email is case insensitive" do
    @user.save
    user1 = FactoryGirl.build(:user, email: @user.email.upcase)
    expect(user1).to_not be_valid
  end

  it "an email is stored as lower-case" do
    user1 = FactoryGirl.create(:user, email: 'WowZa@example.com')
    expect(user1.email).to eq('wowza@example.com')
  end

  it "a name with more than 50 characters is not valid" do
    user1 = FactoryGirl.build(:user, name: "a"*51)
    expect(user1).to_not be_valid
  end

  it "should be not be valid without email" do
    user1 = FactoryGirl.build(:user, email: "")
    expect(user1).to_not be_valid
  end

  it "should have a password digest" do
    expect(@user).to respond_to(:password_digest)
    expect(@user).to respond_to(:password)
    expect(@user).to respond_to(:password_confirmation)
  end

  it "should not be valid with a mismatched password confirmation" do
    user1 = FactoryGirl.build(:user, password_confirmation: "no way")
    expect(user1).to_not be_valid
  end

  it "should respond to authenticate" do
    expect(@user).to respond_to(:authenticate)
  end

  it "should be found with a valid password" do
    @user.save
    user = User.find_by(email: @user.email)
    expect(user).to eq(user.authenticate(@user.password))
  end

  it "should not be found with an invalid password" do
    @user.save
    user = User.find_by(email: @user.email)
    expect(user).to_not eq(user.authenticate("invalid"))
  end

  it "should have a password of at least 6 characters" do
    user1 = FactoryGirl.build(:user, password: "y"*5,
                                     password_confirmation: "y"*5)
    expect(user1).to_not be_valid
  end

  it "should have a remember_token token" do
    expect(@user).to respond_to(:remember_token)
    expect(@user.remember_token).to be_blank
    @user.save
    expect(@user.remember_token).to_not be_blank
  end



end
