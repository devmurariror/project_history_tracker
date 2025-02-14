require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:projects) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe 'devise validations' do
    let(:user) { build(:user) }

    it 'validates email format' do
      user.email = 'invalid-email'
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('is invalid')
    end

    it 'validates password presence' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates password length' do
      user.password = 'short'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe 'valid user' do
    let(:user) { build(:user) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
  end

  describe 'invalid user' do
    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
