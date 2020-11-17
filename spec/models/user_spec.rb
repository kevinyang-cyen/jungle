require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    User.destroy_all

    it "saves successfully" do
      user1 = User.create!({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: '12345'
      })
      expect(user1.errors.full_messages).to eq([])
    end

    it "checks that password and password confirmation are the same" do
      user2 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: '12346'
      })
      expect(user2.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "checks that password is entered" do
      user3 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: "",
        password_confirmation: '12346'
      })
      expect(user3.errors.full_messages).to include("Password can't be blank")
    end

    it "checks that password_confirmation is entered" do
      user4 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: ""
      })
      expect(user4.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "checks if email already exists" do
      user5 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: "12345"
      })
      user6 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'FIRstlast@gmail.com',
        password: '12345',
        password_confirmation: "12345"
      })
      expect(user6.errors.full_messages).to include("Email has already been taken")
    end

    it "checks that email exists" do
      user7 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: nil,
        password: '12345',
        password_confirmation: '12345'
      })
      expect(user7.errors.full_messages).to include("Email can't be blank")
    end

    it "checks that first name exists" do
      user7 = User.create({
        first_name: nil,
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: '12345'
      })
      expect(user7.errors.full_messages).to include("First name can't be blank")
    end

    it "checks that last name exists" do
      user7 = User.create({
        first_name: 'first',
        last_name: nil,
        email: 'firstlast@gmail.com',
        password: '12345',
        password_confirmation: '12345'
      })
      expect(user7.errors.full_messages).to include("Last name can't be blank")
    end

  end
end
