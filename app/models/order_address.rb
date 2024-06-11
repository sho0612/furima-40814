# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id
    validates :municipalities
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter only 10 or 11 digits' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    return false unless valid?

    order = Order.create(user_id:, item_id:)
    Address.create(post_code:, prefecture_id:, municipalities:, street:,
                   building:, phone_number:, order_id: order.id)
  end
end
