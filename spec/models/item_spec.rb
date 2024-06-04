require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(item).to be_valid
    end

    it 'is not valid without a user' do
      item = Item.new(user: nil)
      item.valid?
      expect(item.errors.full_messages).to include("User must exist")
    end

    it 'is not valid without a name' do
      item.name = nil
      expect(item).to_not be_valid
      expect(item.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a description' do
      item.description = nil
      expect(item).to_not be_valid
      expect(item.errors[:description]).to include("can't be blank")
    end

    it 'is not valid without a price' do
      item.price = nil
      expect(item).to_not be_valid
      expect(item.errors[:price]).to include("can't be blank")
    end

    it 'is not valid with a price less than 300' do
      item.price = 299
      expect(item).to_not be_valid
      expect(item.errors[:price]).to include('must be a number between ¥300 and ¥9,999,999')
    end

    it 'is not valid with a price greater than 9999999' do
      item.price = 10_000_000
      expect(item).to_not be_valid
      expect(item.errors[:price]).to include('must be a number between ¥300 and ¥9,999,999')
    end

    it 'is not valid with a non-integer price' do
      item.price = 'nine hundred'
      expect(item).to_not be_valid
      expect(item.errors[:price]).to include('must be a number between ¥300 and ¥9,999,999')
    end

    it 'is not valid without a category_id' do
      item.category_id = 1
      expect(item).to_not be_valid
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it 'is not valid without a condition_id' do
      item.condition_id = 1
      expect(item).to_not be_valid
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    it 'is not valid without a shipping_fee_id' do
      item.shipping_fee_id = 1
      expect(item).to_not be_valid
      expect(item.errors[:shipping_fee_id]).to include("can't be blank")
    end

    it 'is not valid without a prefecture_id' do
      item.prefecture_id = 1
      expect(item).to_not be_valid
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it 'is not valid without a shipping_day_id' do
      item.shipping_day_id = 1
      expect(item).to_not be_valid
      expect(item.errors[:shipping_day_id]).to include("can't be blank")
    end

    it 'is not valid without an image' do
      item.image = nil
      expect(item).to_not be_valid
      expect(item.errors[:image]).to include("can't be blank")
    end
  end
end
