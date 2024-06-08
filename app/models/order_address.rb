# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street, :building, :phone_number, :user_id, :item_id


  validates :post_code, presence: true
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :prefecture_id, :municipalities, :street, :phone_number, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Enter only 10 or 11 digits" }

  def save
    return false unless valid?

    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street: street, building: building, phone_number: phone_number, order_id: order.id)
  end
end