require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    User.destroy_all

    it "saves successfully" do
      user1 = User.create!({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(user1.errors.full_messages).to eq([])
    end

    it "checks that password and password confirmation are the same" do
      user2 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
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
        password: '123456',
        password_confirmation: ""
      })
      expect(user4.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "checks if email already exists" do
      user5 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: "123456"
      })
      user6 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'FIRstlast@gmail.com',
        password: '123456',
        password_confirmation: "123456"
      })
      expect(user6.errors.full_messages).to include("Email has already been taken")
    end

    it "checks that email exists" do
      user7 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: nil,
        password: '123456',
        password_confirmation: '123456'
      })
      expect(user7.errors.full_messages).to include("Email can't be blank")
    end

    it "checks that first name exists" do
      user8 = User.create({
        first_name: nil,
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(user8.errors.full_messages).to include("First name can't be blank")
    end

    it "checks that last name exists" do
      user9 = User.create({
        first_name: 'first',
        last_name: nil,
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(user9.errors.full_messages).to include("Last name can't be blank")
    end

    it "checks minimum length of password" do
      user10 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '12',
        password_confirmation: '12'
      })
      expect(user10.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it "authenticates correctly" do
      user1 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(User.authenticate_with_credentials(user1.email, user1.password)).to eq(user1) 
      expect(User.authenticate_with_credentials(user1.email, 'abcdef')).to be false
    end
  end

  describe 'authentication edge cases' do
    it "authenticates correctly even when there are extra spaces around emails" do
      user1 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlast@gmail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(User.authenticate_with_credentials('   firstlast@gmail.com  ', user1.password)).to eq(user1)     
    end

    it "authenticates correctly even when email is not cased correctly" do
      user1 = User.create({
        first_name: 'first',
        last_name: 'last',
        email: 'firstlAst@GMail.com',
        password: '123456',
        password_confirmation: '123456'
      })
      expect(User.authenticate_with_credentials('fIRstlast@gmaIL.com', user1.password)).to eq(user1)  
    end
  end
end
