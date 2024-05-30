# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a nickname' do
      user.nickname = nil
      expect(user).to_not be_valid
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: user.email)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'is not valid without a valid email format' do
      user.email = 'invalidemail.com'
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is not valid with a password less than 6 characters' do
      user.password = '12345'
      user.password_confirmation = '12345'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'is not valid without a first name' do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'is not valid without a last name' do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'is not valid without a first name kana' do
      user.first_name_kana = nil
      expect(user).to_not be_valid
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it 'is not valid without a last name kana' do
      user.last_name_kana = nil
      expect(user).to_not be_valid
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it 'is not valid without a birth date' do
      user.birth_date = nil
      expect(user).to_not be_valid
      expect(user.errors[:birth_date]).to include("can't be blank")
    end
  end

  context 'custom validations' do
    it 'is not valid with a password without letters and numbers' do
      user.password = 'password'
      user.password_confirmation = 'password'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("must include both letters and numbers")
    end

    it 'is not valid with a first name not in full-width characters' do
      user.first_name = 'Taro'
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("must be full-width characters (kanji, hiragana, katakana)")
    end

    it 'is not valid with a last name not in full-width characters' do
      user.last_name = 'Yamada'
      expect(user).to_not be_valid
      expect(user.errors[:last_name]).to include("must be full-width characters (kanji, hiragana, katakana)")
    end

    it 'is not valid with a first name kana not in katakana' do
      user.first_name_kana = 'たろう'
      expect(user).to_not be_valid
      expect(user.errors[:first_name_kana]).to include("must be full-width katakana characters")
    end

    it 'is not valid with a last name kana not in katakana' do
      user.last_name_kana = 'やまだ'
      expect(user).to_not be_valid
      expect(user.errors[:last_name_kana]).to include("must be full-width katakana characters")
    end
  end
end
