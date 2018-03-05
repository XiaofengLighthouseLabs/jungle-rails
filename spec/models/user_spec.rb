require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user with all validations' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      expect(@user.valid?).to be true
    end

    it 'should not be allowed to create a user if password is not match password_confirmation' do
      @user = User.new(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test5678")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn\'t match Password")
    end

    it 'should not be allowed to create a user if email is not unique case insensitive' do
      @user1 = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.new(name:"Grace", email:"gRAce@example.com", password:"test5678", password_confirmation:"test5678")
      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not be allowed to create a user without name' do
      @user = User.new(email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Name can\'t be blank")
    end

    it 'should not be allowed to create a user without email' do
      @user = User.new(name:"Grace", password:"test1234", password_confirmation:"test1234")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Email can\'t be blank")
    end

    it 'should not be allowed to create a user if password is less than 6' do
      @user = User.new(name:"Grace", email:"grace@example.com", password:"test", password_confirmation:"test")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

     it 'should not be allowed to create a user without password' do
      @user = User.new(name:"Grace", email:"grace@example.com",password_confirmation:"test1234")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password can\'t be blank")
    end

     it 'should not be allowed to create a user without password_confirmation' do
      @user = User.new(name:"Grace", email:"grace@example.com",password:"test1234")
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation is too short (minimum is 6 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    it 'should be return instance of the user with valid email and password' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.authenticate_with_credentials("grace@example.com", "test1234")
      expect(@user2).to be_eql @user
    end

    it 'should be return instance of the user with whitespaced email' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.authenticate_with_credentials("  grace@example.com", "test1234")
      expect(@user2).to be_eql @user
    end

    it 'should be return instance of the user with email with diff case' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.authenticate_with_credentials("grAce@example.cOm", "test1234")
      expect(@user2).to be_eql @user
    end

    it 'should be return nil if user with diff email' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.authenticate_with_credentials("grace2@example.com", "test1234")
      expect(@user2).to be_eql nil
    end

    it 'should be return nil if user with diff password' do
      @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")
      @user2 = User.authenticate_with_credentials("grace@example.com", "test5678")
      expect(@user2).to be_eql nil
    end

  end

end
