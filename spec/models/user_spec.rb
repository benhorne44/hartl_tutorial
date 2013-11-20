require 'spec_helper'

describe User do

  def user_attributes
    { name: "Mickey",
      email: "mickey@example.com"
    }
  end

  before {@user = User.new(user_attributes)}

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
    user1 = User.new(user_attributes.merge(name: ""))
    expect(user1).to_not be_valid
  end

  it "a user is invalid with an invalid email" do
    addresses = ['user@foo,com', 'user_at_foo.org', 'example.user@foo.',
                 'foo@bar_baz.com', 'foo@bar+baz.com']
    addresses.each do |invalid_address|
      user1 = User.new(user_attributes.merge(email: invalid_address))
      expect(user1).to_not be_valid
    end
  end

  it "an email must be unique" do
    @user.save
    user1 = User.new(user_attributes.merge(email: @user.email))
    expect(user1).to_not be_valid
  end

  it "an email is case insensitive" do
    @user.save
    user1 = User.new(user_attributes.merge(email: @user.email.upcase))
    expect(user1).to_not be_valid
  end

  it "a name with more than 50 characters is not valid" do
    user1 = User.new(user_attributes.merge(name: "a"*51))
    expect(user1).to_not be_valid
  end

  it "a user should be not be valid without email" do
    user1 = User.new(user_attributes.merge(email: ""))
    expect(user1).to_not be_valid
  end

end
